class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: user_params[:email])
    if valid(user)
      log_in(user)
      route_user(user)
    else
      flash.now[:danger] = "Incorrect login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def route_user(user)
    if user.role == 'admin'
      redirect_to admin_cards_path
    else
      redirect_to root_path
    end
  end
end
