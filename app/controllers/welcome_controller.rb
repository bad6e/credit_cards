class WelcomeController < ApplicationController
  def index
    @welcome_presenter = WelcomePresenter.new
  end
end
