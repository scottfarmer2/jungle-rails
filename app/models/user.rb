class User < ActiveRecord::Base
  has_secure_password

  has_many :review

  validates :email, presence: true, confirmation: true, uniqueness: { case_sensitive: false }
  validates :email_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
  # validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create

  def self.authenticate_with_credentials(email, password)
    email.downcase!
    email.strip!
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    end
  end
end
