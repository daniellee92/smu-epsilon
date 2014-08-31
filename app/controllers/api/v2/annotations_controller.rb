class Api::V2::AnnotationsController < AnnotationsController
	skip_before_action :verify_authenticity_token
	respond_to :json

	def create
		@annotation = Annotation.new(annotation_params)
    	
		if @annotation.save
			render status: 201, json: { :annotation_id => @annotation.id }
		else
			# check if this works
			render status: 422, json: { :error => @annotation.errors }
		end
	end

	private

		def annotation_params
		    params.permit(:x_axis, :y_axis, :details, :image_id, :feedback_id)
			# require(:feedback)
	    end
end