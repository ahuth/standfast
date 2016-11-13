class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to(teams_path)
    else
      render layout: "marketing"
    end
  end
end
