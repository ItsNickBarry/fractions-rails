# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  username             :string
#  uuid                 :string           not null
#  password_digest      :string           not null
#  session_token        :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  current_character_id :integer
#

class User < ActiveRecord::Base
  after_initialize :ensure_session_token
  before_validation :verify_params!

  validates :username, :uuid, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }
  validate :owns_current_character
  validate :password_does_not_match_username
  # TODO validate :password_is_not_among_top_10000

  has_many :characters
  belongs_to :current_character, class_name: 'Character'

  def self.find_by_credentials(params)
    user = User.find_by(uuid: params[:uuid])
    user.try(:is_password?, params[:password]) ? user : nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def password
    @password
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def can_create_character?
    # TODO user create character conditions
    characters.length < 10
  end

  private

    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end

    def owns_current_character
      return if self.current_character_id.nil?
      unless current_character && current_character.user.id == self.id
        errors.add(:current_character_id, "does not belong to user")
      end
    end

    def password_does_not_match_username
      errors.add(:password, "must not match username") if self.password == self.username
    end

    def verify_params!
      if self.uuid.nil?
        profile = MojangApiConnection.get_profile_given_username(self.username)
        if profile
          self.username = profile['username']
          self.uuid = profile['uuid']
          self.attributes.merge!(profile)
        else
          errors.add(:username, "is not a Minecraft username")
        end
      end
    end
end
