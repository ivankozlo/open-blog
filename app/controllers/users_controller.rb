class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_user, except: %i[index show create new]
  before_action :require_same_user, only: %i[edit update]
  before_action :require_admin, only: [:destroy]
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Open blog #{@user.username}"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account was updated successfully'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy unless @user.admin?
    flash[:danger] = "User #{@user.username} has been removed and all of articles he/she created also have been removed"
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = 'You can only edit or delete your own profile'
      redirect_to root_path
    end
  end

  def require_admin
    if signed_in? && !current_user.admin?
      flash[:danger] = 'Only admin users can perform this action'
      redirect_to root_path
    end
  end
end
