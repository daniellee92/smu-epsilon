class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session#, if: Proc.new { |c| c.request.format == 'application/json' }

  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  helper_method :current_user

  # skip_before_action :verify_authenticity_token, if: :json_request?

  # This is our new function that comes before Devise's one
  #before_filter :authenticate_user_from_token!

  # This is Devise's authentication
  #before_filter :authenticate_user!
 
  #private
  
  # For this example, we are simply using token authentication
  # via parameters. However, anyone could use Rails's token
  # authentication features to get the token from a header.
  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user       = user_token && User.find_by_authentication_token(user_token.to_s)
 
    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    end
  end

  #Get the current signed in user
  def current_user=(user)
    @current_user = user
  end

  # def verify_authenticity_token
  #   @current_user = User.find_by_authentication_token(params[:auth_token])
  #   render status: 401, json: { :message => "Invalid token." } and return unless @current_user
  # end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :nickname
    devise_parameter_sanitizer.for(:sign_up) << :phone_number
  end

  # def json_request?
  #   request.format.json?
  # end

end
