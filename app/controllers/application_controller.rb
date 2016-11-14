class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    request.env["omniauth.origin"] || stored_location_for(resource) || teams_path
  end

  def current_account
    current_user.account
  end
end
