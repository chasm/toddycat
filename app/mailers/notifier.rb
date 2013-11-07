class Notifier < ActionMailer::Base
  default from: "ToddyCat <admin@toddycat.com>"
  
  def password_reset_request(user, request)
    @user = user
    @host = request.protocol + request.host_with_port
    
    mail to: @user.email, subject: "ToddyCat: Reset your credentials"
  end
  
  def registration_request(registrant, request)
    @registrant = registrant
    @host = request.protocol + request.host_with_port
    
    mail to: @registrant.email, subject: "ToddyCat: Complete your registration"
  end
end