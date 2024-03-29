class MicropostsController < ApplicationController
  before_filter :signed_in_user,    only: [:create, :destroy]
  before_filter :correct_user,      only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])

      if @micropost.save
        redirect_to root_path, notice: 'Micropost was successfully created.'
      else
        redirect_to user_path(current_user), notice: @micropost.errors.full_messages.join
      end
  end

  def destroy
    @micropost.destroy
    redirect_to root_path
  end
  
  private
  
    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
end