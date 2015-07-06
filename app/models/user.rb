# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  uuid            :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  after_initialize :ensure_session_token

  validates :username, :uuid, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }

  has_many :characters

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

  private

    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end
end
