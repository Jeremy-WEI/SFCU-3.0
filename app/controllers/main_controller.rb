class MainController < ApplicationController
  http_basic_authenticate_with :name => MainHelper.name, :password => MainHelper.password, only: :index

  def index
    reset_session
  end
end
