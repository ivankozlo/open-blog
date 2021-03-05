class HomeController < ApplicationController
  def index
    redirect_to articles_path if signed_in?
  end

  def about; end
end
