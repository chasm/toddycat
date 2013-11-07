class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  PASSWORD_RESET_EXPIRES = 1.hour
  
  attr_accessor :password, :password_confirmation
  
  before_save :encrypt_password
  before_save :downcase_email
  
  field :id
  field :name, type: String
  
  # For log in
  field :email, type: String
  field :salt, type: String
  field :fish, type: String
  
  # For password reset
  field :code, type: String
  field :expires_at, type: Time
  
  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\Z/i }
  validates :password, presence: true, on: :create
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, unless: Proc.new { |user| user.password.blank? }
  
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user.password_matches?(password) if user
  end
  
  def self.find_by_code(code)
    if user = User.find_by(:code => code, :expires_at.gte => Time.now.gmtime)
      user.set_expiration
      user.save!
      return user
    end
    
    nil
  end
  
  def set_password_reset
    self.code = SecureRandom.urlsafe_base64
    set_expiration
    self.save!
  end
  
  def set_expiration
    self.expires_at = PASSWORD_RESET_EXPIRES.from_now
  end
  
  def password_matches?(password)
    return self if self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end
  
  def reset_password(password_params)
    if self.update(password_params)
      self.unset(:code)
      self.unset(:expires_at)
    end
  end
  
  protected
  
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.fish = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end
  
  def downcase_email
    self.email.downcase!
  end
end