class PasswordReset
  RESET_MESSAGE = %{
    An email with instructions for resetting your password
    has been sent to you. }.squish
  
  def initialize(request)
    @request = request
  end
  
  def send_password_reset(user)
    user.set_password_reset

    Notifier.reset_email(user, @request).deliver
    
    RESET_MESSAGE
  end
  
  def reset_password(user, params)
    user.reset_password(password_params(params))
  end
  
  private

  def password_params(params)
    params.require(:user).permit( :password, :password_confirmation )
  end
end