class HomeController < ApplicationController
    before_action :authenticate_user!

  def index
    if current_user.manager
      redirect_to portfolios_url, notice: "Manager Logged In"
    else
      redirect_to "/portfolios/#{current_user.portfolio.id}"\
    end
  end
end
