class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def is_manager?
    unless current_user.manager
      flash[:error] = 'You must be logged in to access this section'
      redirect_to root_url # halts request cycle
    end
  end
end
