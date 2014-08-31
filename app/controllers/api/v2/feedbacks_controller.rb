class Api::V2::FeedbacksController < FeedbacksController
skip_before_action :verify_authenticity_token
respond_to :json

	def display_all_listing2
		retrieve_before_time_dt = DateTime.strptime(params[:retrieve_before_time], '%Y-%m-%d %H:%M:%S')
	    feedbacks = Feedback.order(last_acted_at: :desc).where("last_acted_at < ?", retrieve_before_time_dt).limit(10).joins(:user)
		render json: { :all_feedbacks_list => feedbacks }
	end

	def display_details
		feedback = Feedback.find(params[:feedback_id])
		created_at = feedback.created_at.strftime("%Y-%m-%d %H:%M:%S")
		last_acted_at = feedback.last_acted_at.strftime("%Y-%m-%d %H:%M:%S")
		nickname = User.find(feedback.user_id).nickname
		render json: { :feedback => feedback, :nickname => nickname, :created_at => created_at, :last_acted_at => last_acted_at }
	end

	def create
		@current_user = User.find_by_authentication_token(params[:auth_token])
    	render status: 401, json: { :error => "Invalid token." } and return unless @current_user

    	@feedback = Feedback.new(feedback_params)
    	
		if @feedback.save
			@feedback.update_attribute(:last_acted_at, Time.zone.now)
			@feedback.update_attribute(:user_id, @current_user.id)
			render status: 201, json: { :feedback_id => @feedback.id }
		else
			# check if this works
			render status: 422, json: { :error => @feedback.errors }
		end
	end

	private

		def feedback_params
		    params.permit(:title, :details, :address, :latitude, :longitude, :detailed_location, :image1, :image2, :image3, :image4, :image5)
			# require(:feedback)
	    end
end
