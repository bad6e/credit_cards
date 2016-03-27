class UsersController < ApplicationController
  before_action :load_user, only: [:update, :destroy]
  def show
    if !current_user
      redirect_to root_path
    end
    @user_presenter = UserPresenter.new
  end

  def edit
  end

  def update
    if @user.update(email: user_params[:email])
      @user.update(updated_email: true)
      flash[:success] = "Your email has been updated to #{@user.email}"
      redirect_to user_path(@user)
    else
      flash.now[:errors] = @user.errors.full_messages.join(", ")
      render user_path(@user)
    end
  end

  def destroy
    user_name = @user.name
    session[:user_id] = nil
    @user.delete
    flash[:success] = "We are sorry to see you go, #{user_name}!"
    redirect_to root_path
  end

  private

    def load_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:id, :email)
    end
end
