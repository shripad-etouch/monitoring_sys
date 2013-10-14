class UrlRequestResponse
  include Mongoid::Document
  require 'mongo_patch_id'
  field :url, type: String
  #field :verb_id, type: String
  #field :request_header, type: String
  #field :request_body, type: String
  #field :response_header, type: String
  #field :response_body, type: String
  field :timeout, type: Integer
  #field :request_object_type_id, type: String
  #referenced_in :verb
  belongs_to :verb
  belongs_to :request_object_type
  has_many :schedules
  has_many :request_responses
end
