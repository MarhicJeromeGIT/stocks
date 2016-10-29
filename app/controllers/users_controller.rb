class UsersController < ApplicationController
  
  def show
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    
    @alerts = current_user.alerts
  end
end
