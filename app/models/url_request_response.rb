class UrlRequestResponse
  include Mongoid::Document
  require 'mongo_patch_id'
  field :url, type: String
  field :http_verb, type: String
  field :request_header, type: String
  field :request_body, type: String
  field :expected_response_header, type: String
  field :expected_response_body, type: String
  field :timeout, type: String
  field :object_type, type: String
  field :time_to_run, type: DateTime
  has_many :schedule_detail
end
