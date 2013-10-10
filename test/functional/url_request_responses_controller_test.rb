require 'test_helper'

class UrlRequestResponsesControllerTest < ActionController::TestCase
  setup do
    @url_request_response = url_request_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:url_request_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create url_request_response" do
    assert_difference('UrlRequestResponse.count') do
      post :create, url_request_response: { request_body: @url_request_response.request_body, request_header: @url_request_response.request_header, request_object_type_id: @url_request_response.request_object_type_id, response_body: @url_request_response.response_body, response_header: @url_request_response.response_header, timeout: @url_request_response.timeout, url: @url_request_response.url, verb_id: @url_request_response.verb_id }
    end

    assert_redirected_to url_request_response_path(assigns(:url_request_response))
  end

  test "should show url_request_response" do
    get :show, id: @url_request_response
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @url_request_response
    assert_response :success
  end

  test "should update url_request_response" do
    put :update, id: @url_request_response, url_request_response: { request_body: @url_request_response.request_body, request_header: @url_request_response.request_header, request_object_type_id: @url_request_response.request_object_type_id, response_body: @url_request_response.response_body, response_header: @url_request_response.response_header, timeout: @url_request_response.timeout, url: @url_request_response.url, verb_id: @url_request_response.verb_id }
    assert_redirected_to url_request_response_path(assigns(:url_request_response))
  end

  test "should destroy url_request_response" do
    assert_difference('UrlRequestResponse.count', -1) do
      delete :destroy, id: @url_request_response
    end

    assert_redirected_to url_request_responses_path
  end
end
