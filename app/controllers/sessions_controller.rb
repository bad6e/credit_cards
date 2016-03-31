class SessionsController < ApplicationController
  before_action :no_index_no_follow, only: [:new]

  def new
  end

  def create
    begin
      user = User.from_omniauth(request.env['omniauth.auth'])
      log_in(user)
      flash[:success] = "Welcome, #{user.name}!"
      route_user(user)
    rescue
      flash[:errors] = "There was a problem with your authentication!"
    end
  end

  def create_standard
    user = User.find_by(email: user_params[:email])
    if valid(user)
      log_in(user)
      route_user(user)
    else
      render :new
      flash[:errors] = "Incorrect Login"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def auth_failure
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

    def route_user(user)
      if user.role == 'admin'
        redirect_to admin_cards_path
      else
        redirect_to request.env['omniauth.origin']
      end
    end
end
