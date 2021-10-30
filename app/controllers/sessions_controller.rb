class SessionsController < ApplicationController

  def googleAuth
      # Get access tokens from the google server
      logger.debug(request.env["omniauth.state"])
      access_token = request.env["omniauth.auth"]
      user = User.from_omniauth(access_token)
      log_in(user)
      # Access_token is used to authenticate request made from the rails application to the google server
      user.google_token = access_token.credentials.token
      # Refresh_token to request new access_token
      # Note: Refresh_token is only sent once during the first request
      refresh_token = access_token.credentials.refresh_token
      user.google_refresh_token = refresh_token if refresh_token.present?
      user.save
      redirect_to root_path
    end

  def index

    render 'index'
  end

  protected
  def check_current_user
    if session[:uid] == null
      flash[:msg] = "Please log in"
      redirect_to root_path
    end
    @current_user = User.find(session[:uid])
  end

  protected
  def log_in(user)
    session[:uid] = user.id
  end

end