class SessionsController < ApplicationController
  before_action :test_func
  
  def googleAuth
    # Get access tokens from the google server
    logger.debug(request.env["omniauth.state"])
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    # Access_token is used to authenticate request made from the rails application to the google server
    user.google_token = access_token.credentials.token
    # Refresh_token to request new access_token
    # Note: Refresh_token is only sent once during the first request
    refresh_token = access_token.credentials.refresh_token
    user.google_refresh_token = refresh_token if refresh_token.present?
    User.transaction do
      user.save!
    end
    # User.connection.commit_db_transaction
    log_in(user)
    if Profile.where(user_id: user.id).length == 0
      Profile.create(user_id: user.id)
      redirect_to new_profile_path
    else
      redirect_to root_path
    end
    
  end

  def index
    #reset_session
    if session[:uid]!=nil 
      @current_user = User.find(session[:uid])       
    else
      @current_user=nil    
    end
  end
  
  
  def logout
    reset_session
    @current_user = nil
    render 'index'
  end 
  
  protected
  def check_current_user
    if Rails.env.test?  
      @current_user = User.find(1)
    else 
      if session[:uid] == nil
        flash[:msg] = "Please log in"
        redirect_to root_path
      end
      @current_user = User.find(session[:uid])
    end
  end

  protected
  def test_func
    if Rails.env.test?
      begin
        User.find(1)
        session[:uid] = 1
      rescue
      end
    end
  end

  protected
  def log_in(user)
    session[:uid] = user.id
  end

  def add_attribute(klass, symbol)
    codes = %Q{
    def #{symbol}
        return @#{symbol}
    end
    def #{symbol}=(value)
        @#{symbol} = value
    end
    }

    klass.instance_eval(codes)
  end

end