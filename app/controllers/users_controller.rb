class UsersController < ApplicationController
  def show
    if !current_user
      redirect_to root_path
    end
    @user_presenter = UserPresenter.new
  end
end
