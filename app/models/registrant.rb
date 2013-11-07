class Registrant
  include Mongoid::Document
  
  REGISTRATION_EXPIRES = 1.day
  
  before_create :set_id
  before_create :set_expiration
  after_create  :clean_up
  
  field :id
  field :email
  field :expires_at, type: Time
  
  validates :email, presence: true
  validates :email, format: { with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\Z/i }
  
  def self.find_by_code(id)
    if registrant = Registrant.find_by(:id => id, :expires_at.gte => Time.now.gmtime)
      registrant.set_expiration
      registrant.save!
      return registrant
    end
    
    nil
  end
  
  def set_expiration
    self.expires_at = REGISTRATION_EXPIRES.from_now
  end
  
  protected
  
  def set_id
    self.id = SecureRandom.urlsafe_base64
  end
  
  def clean_up
    Registrant.destroy_all(:expires_at.lt => Time.now.gmtime)
  end
end