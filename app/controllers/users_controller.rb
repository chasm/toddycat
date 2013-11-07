class UsersController < ApplicationController
  
  def index
    @users = User.all.entries
    
    render json: @users
  end
  
  def show
    @user = User.find_by(id: params[:id])
    
    render json: @user
  end
  
  def create
  end
  
  def update
  end
  
  def destroy
  end
end