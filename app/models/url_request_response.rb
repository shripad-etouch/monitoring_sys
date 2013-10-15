class UrlRequestResponse
  include Mongoid::Document
  require 'mongo_patch_id'
  field :url, type: String
  field :timeout, type: String
  field :request_header, type: String
  field :request_body, type: String
  belongs_to :verb
  belongs_to :request_object_type
  has_many :schedules
  has_many :request_responses
end
