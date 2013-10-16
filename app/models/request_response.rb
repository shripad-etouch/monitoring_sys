class RequestResponse
  include Mongoid::Document

  field :response_header, type: String
  field :response_body, type: String
  belongs_to :url_request_response
  belongs_to :schedule
end
