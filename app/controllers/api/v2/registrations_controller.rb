class Api::V2::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
      @user = User.new(params)
      if @user.save
        @user.ensure_authentication_token
        render :status => 201, :json => { :auth_token=>@user.authentication_token }
        return
      else
        warden.custom_failure!
        render :status => 422, :json => @user.errors
      end
  end

end