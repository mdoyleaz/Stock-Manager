class PagesController < ApplicationController
  def index
    config.authorize_with :cancan
  end

  def home
    puts "hi"
  end
end
