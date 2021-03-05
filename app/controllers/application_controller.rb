class ApplicationController < ActionController::Base
  helper_method :current_user, :signed_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def require_user
    unless signed_in?
      flash[:danger] = 'You must be sign in to perform that action'
      redirect_to root_path
    end
  end
end
