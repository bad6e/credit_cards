class UsersController < ApplicationController
  def show
    if !current_user
      redirect_to root_path
    end
    @user_presenter = UserPresenter.new
    @user = current_user
  end

  def edit

  end

  def update
    binding.pry
  end

  def destroy
    user = User.find(params[:id])
    user_name = user.name
    session[:user_id] = nil
    user.delete
    flash[:success] = "We are sorry to see you go, #{user_name}!"
    redirect_to root_path
  end
end
