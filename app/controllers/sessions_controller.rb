class SessionsController < ApplicationController
  def new; end

  def create
    # render plain: params
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'Sign in succeed'
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'Email or password is incorrect'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have signed out'
    redirect_to root_path
  end
end
