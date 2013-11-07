class Notifier < ActionMailer::Base
  default from: "ToddyCat <admin@toddycat.com>"
  
  def password_reset_request(user)
    @user = user
    
    mail to: @user.email, subject: "[ToddyCat] Reset your credentials"
  end
  
  def password_reset(user)
    @user = user
    
    mail to: @user.email, subject: "[ToddyCat] Your password was reset"
  end
  
  def registration_request(registrant)
    @registrant = registrant
    
    mail to: @registrant.email, subject: "[ToddyCat] Complete your registration"
  end
  
  def registration(user)
    @user = user
    
    mail to: @user.email, subject: "[ToddyCat] Thank you for registering"
  end
end