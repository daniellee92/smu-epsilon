require 'test_helper'

class FeedbacksControllerTest < ActionController::TestCase
  setup do
    @feedback = feedbacks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feedbacks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feedback" do
    assert_difference('Feedback.count') do
      post :create, feedback: { address: @feedback.address, detailed_location: @feedback.detailed_location, details: @feedback.details, last_acted_at: @feedback.last_acted_at, latitude: @feedback.latitude, longitude: @feedback.longitude, reported_by: @feedback.reported_by, status: @feedback.status, title: @feedback.title }
    end

    assert_redirected_to feedback_path(assigns(:feedback))
  end

  test "should show feedback" do
    get :show, id: @feedback
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feedback
    assert_response :success
  end

  test "should update feedback" do
    patch :update, id: @feedback, feedback: { address: @feedback.address, detailed_location: @feedback.detailed_location, details: @feedback.details, last_acted_at: @feedback.last_acted_at, latitude: @feedback.latitude, longitude: @feedback.longitude, reported_by: @feedback.reported_by, status: @feedback.status, title: @feedback.title }
    assert_redirected_to feedback_path(assigns(:feedback))
  end

  test "should destroy feedback" do
    assert_difference('Feedback.count', -1) do
      delete :destroy, id: @feedback
    end

    assert_redirected_to feedbacks_path
  end
end
