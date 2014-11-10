class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_credentials(params[:session][:username],
                                    params[:session][:password])
    if user
      login!(user)
      redirect_to subs_url
    else
      flash[:errors] = "Invalid username or password" 
      redirect_to new_session_url
    end
  end
  
  def destroy
    logout
    redirect_to new_session_url
  end
end