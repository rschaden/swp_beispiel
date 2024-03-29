class UsersController < ApplicationController
  before_filter :signed_in_user,    only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,      only: [:edit, :update]
  
  def index 
    @users = User.paginate(page: params[:page]) 
  end

  def show
    @user = User.find(params[:id])
    @micropost = current_user.microposts.build if signed_in?
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
      if @user.save
        sign_in @user
        redirect_to @user, notice: 'User was successfully created.'
      else
        render action: "new" 
      end    
  end
  
  def update
    @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        sign_in @user
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render action: "edit"
      end
    end
    
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, 'User deleted.'
  end
  
  private
    def signed_in_user
      store_location
      redirect_to signin_path, notice: "Please sign in" unless signed_in?
    end
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
