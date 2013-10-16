class MontioringSysController < ApplicationController
  def index
      @http_verbs = Verb.all
      @object_types = RequestObjectType.all
  end
end
