class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :update, :destroy]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.order(last_acted_at: :desc)
  end


  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    @nickname = User.find(@feedback.user_id).nickname
    #display the location of the issue on google map
    @hash = Gmaps4rails.build_markers(@feedback) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.title
    end
  end


  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
        format.json { render :show, status: :ok, location: @feedback }
      else
        format.html { render :edit }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:title, :details, :address, :latitude, :longitude, :detailed_location)
    end
end