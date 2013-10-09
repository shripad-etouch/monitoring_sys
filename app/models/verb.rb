class Verb
  #attr_accessible :name
  include Mongoid::Document
  field :name
end
