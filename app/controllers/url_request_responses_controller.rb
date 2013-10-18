class UrlRequestResponsesController < ApplicationController
  # GET /url_request_responses
  # GET /url_request_responses.json
  def index
    @url_request_responses = UrlRequestResponse.only(:url, :http_verb, :timeout, :object_type, :time_to_run)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @url_request_responses }
    end
  end

  # GET /url_request_responses/1
  # GET /url_request_responses/1.json
  def show
    @url_request_response = UrlRequestResponse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @url_request_response }
    end
  end

  # GET /url_request_responses/new
  # GET /url_request_responses/new.json
  def new
    @url_request_response = UrlRequestResponse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @url_request_response }
    end
  end

  # GET /url_request_responses/1/edit
  def edit
    @url_request_response = UrlRequestResponse.find(params[:id])
  end

  # POST /url_request_responses
  # POST /url_request_responses.json
  def create
    @url_request_response = UrlRequestResponse.new(params[:url_request_response])

    respond_to do |format|
      if @url_request_response.save
        format.html { redirect_to @url_request_response, notice: 'Url request response was successfully created.' }
        format.json { render json: @url_request_response, status: :created, location: @url_request_response }
      else
        format.html { render action: "new" }
        format.json { render json: @url_request_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /url_request_responses/1
  # PUT /url_request_responses/1.json
  def update
    @url_request_response = UrlRequestResponse.find(params[:id])

    respond_to do |format|
      if @url_request_response.update_attributes(params[:url_request_response])
        format.html { redirect_to @url_request_response, notice: 'Url request response was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @url_request_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /url_request_responses/1
  # DELETE /url_request_responses/1.json
  def destroy
    @url_request_response = UrlRequestResponse.find(params[:id])
    @url_request_response.destroy

    respond_to do |format|
      format.html { redirect_to url_request_responses_url }
      format.json { head :no_content }
    end
  end
end
