class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :user_is_creator?
  
  def login!(user)
    session[:session_token] = user.session_token
  end
  
  def logout
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end
  
  def current_user
    User.find_by(session_token: session[:session_token])
  end
  
  def require_login
    redirect_to new_session_url if current_user.nil?
  end
  
  def user_is_creator?(object, id_name)
    current_user.id == object.send(id_name)
  end
  
end
