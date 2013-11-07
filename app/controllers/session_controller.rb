class SessionController < ApplicationController
  before_action :is_authenticated?, only: [ :destroy ]
  
  def new
    redirect_to root_url if current_user
  end
  
  def create
    email = params[:user][:email]
    password = params[:user][:password]
    
    if password.blank?
      if user = User.find_by(email: email)
        flash.now[:notice] = PasswordReset.new(request).send_password_reset(user)
      else
        flash.now[:notice] = UserRegistration.new(request).send_email_verification(email)
      end
      
      render :new
    else
      if user = User.authenticate(email, password)
        session[:user_id] = user.id
        
        redirect_to root_url
      else
        flash.now[:error] = "Unable to sign you in. Please try again."
        
        render :new
      end
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "You've logged out."
  end
end
