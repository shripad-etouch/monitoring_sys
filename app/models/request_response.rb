class RequestResponse
  include Mongoid::Document
  field :request_header, type: String
  field :request_body, type: String
  field :response_header, type: String
  field :response_body, type: String
  belongs_to :url_request_response
end
