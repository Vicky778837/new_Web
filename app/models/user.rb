class User < ApplicationRecord
  has_secure_password
  has_many :articles, dependent: :destroy 
  has_one_attached :avatar
  validates :email, uniqueness: true
  before_update :encrypt_password
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    ForgetpasswordMailer.forgetpassword(self).deliver# This sends an e-mail with a link for the user to reset the password
  end
  # This generates a random password reset token for the user
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  private
  def encrypt_password
      unless self.password_digest.nil?
      self.password_digest = BCrypt::Password.create(self.password_digest)
    end
  end
end


