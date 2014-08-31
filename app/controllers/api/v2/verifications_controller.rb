class Api::V2::VerificationsController < VerificationsController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    @current_user = User.find_by_authentication_token(params[:auth_token])
    render status: 401, json: { :error => "Invalid token." } and return unless @current_user
    render :json => { :delivery_status => super }
  end

  def verify
    @current_user = User.find_by_authentication_token(params[:auth_token])
    render status: 401, json: { :error => "Invalid token." } and return unless @current_user
    render :json => { :verification_message => super }
  end

end