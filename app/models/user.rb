class User < ApplicationRecord
  rolify #strict: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Ignore whitespace and case on email
  before_validation { self.email = email.downcase.strip }
  before_validation { self.username = username.strip }

  # Usernames should be uniqe, regardless of case
  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            },
            length: { minimum: 3, maximum: 20 }

  # Only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_\.\-]*$/, :multiline => true

  # Username should not be someone else's email address
  validate :validate_username
  def validate_username
    if User.where(email: username.downcase.strip).exists?
      errors.add(:username, :invalid)
    end
  end


  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # Override devise builtin login condition to include username
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).first
    end
  end

  # Send emails as ActiveJob queue instead of waiting for response
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
