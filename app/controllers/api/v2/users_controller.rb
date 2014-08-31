class Api::V2::UsersController < UsersController
	skip_before_action :verify_authenticity_token
	respond_to :json

	def email_exists
		render :json => { :email_exists => User.exists?(:email => params[:user_email]) }
	end

	def facebook_login
		user = User.find_by_email(params[:user_email])
		if user != nil
			render :json => { :auth_token => user.authentication_token }
		else
			render status: 401, :json => { :error => "Invalid email." }
		end
	end

	def get_user
		user = User.find_by_authentication_token(params[:auth_token])
		if user != nil
			created_at = user.created_at.strftime("%Y-%m-%d %H:%M:%S")
			render :json => { :user => user, :created_at => created_at }
		else
			render status: 401, json: { :error => "Invalid token." } 
		end
	end
end