class UrlRequestResponse
  include Mongoid::Document
  require 'mongo_patch_id'
  field :url, type: String
  field :http_verb, type: String
  field :http_verb, type: String
  field :request_body, type: String
  field :expected_response_header, type: String
  field :expected_response_body, type: String
  field :timeout, type: String
  field :object_type, type: String
  field :time_to_run, type: DateTime
  has_many :schedule_details, dependent: :destroy
  validates :url, :presence => { :message => 'Url can not be blank'}
  validates :http_verb, :presence => { :message => 'Http request method can not be blank'}
  validates :expected_response_header, :presence => { :message => 'Expected response header can not be blank'}
  validates :expected_response_body, :presence => { :message => 'Expected response body can not be blank'}
  validates :timeout, :presence => { :message => 'Timeout can not be blank'}
  validates :object_type, :presence => { :message => 'Object type can not be blank'}
  validates :time_to_run, :presence => { :message => 'Time to run can not be blank'}
end
