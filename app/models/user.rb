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
  before_validation :ensure_username_and_uuid

  validates :username, presence: true
  validates :uuid, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }
  validate :owns_current_character
  validate :password_must_not_match_username
  # TODO validate :password_is_not_among_top_10000

  has_many :characters
  belongs_to :current_character, class_name: 'Character'

  def self.digest(password)
    BCrypt::Password.create(password)
  end

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
    self.password_digest = User.digest(password)
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
      self.session_token ||= User.generate_session_token
    end

    def ensure_username_and_uuid
      if self.uuid.nil?
        response = MojangApiConnection.get_profile_given_username(self.username)
      else
        response = MojangApiConnection.get_username_given_uuid(self.uuid)
      end

      if response.is_a? Hash
        username = response[:username]
        uuid = self.uuid || response[:uuid]

        conflicting_user = User.find_by(username: username)

        if conflicting_user && conflicting_user != self
          # TODO determine whether it is safe to update_attribute without validation
          conflicting_user.update_attribute(:username, conflicting_user.uuid)
        end
        self.username = username
        self.uuid = uuid
      else
        errors.add(:base, response)
      end
    end

    def owns_current_character
      return if self.current_character_id.nil?
      unless current_character && current_character.user.id == self.id
        errors.add(:current_character_id, "does not belong to user")
      end
    end

    def password_must_not_match_username
      if self.password && self.password.downcase == self.username.downcase
        errors.add(:password, "must not match username")
      end
    end
end
