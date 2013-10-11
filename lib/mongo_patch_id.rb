####This file is included By SSJ 
###This will overried the as_json method of mongo id
###This will give us convert _id to id for uesd throughout in the application
module Mongoid
  module Document
    def as_json(options={})
      attrs = super(options)
      attrs["id"] = self.persisted? ? self._id : nil
      attrs
    end
  end
end