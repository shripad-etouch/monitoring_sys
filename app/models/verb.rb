class Verb
  #attr_accessible :name
  include Mongoid::Document
  field :name
  has_many :url_request_responses
end
