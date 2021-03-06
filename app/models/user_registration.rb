class UserRegistration
  REGISTRATION_MESSAGE = %{
    An email with instructions for completing your registration
    has been sent to you. }.squish
  
  def initialize(request)
    @request = request
  end
  
  def send_email_verification(email)
    registrant = Registrant.create(email: email)
    
    Notifier.registration_request(registrant).deliver
    
    REGISTRATION_MESSAGE
  end
  
  def register_new_user(registrant, params)
    user = User.new(registration_params(params, registrant.email))
    if user.save
      registrant.destroy
      Notifier.registration(user).deliver
    end
    user
  end
  
  private
  
  def registration_params(params, email)
    params.require(:user)
      .merge({ id: SecureRandom.urlsafe_base64, email: email })
      .permit( :id, :name, :email, :password, :password_confirmation )
  end
end