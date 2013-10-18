class MontioringSysController < ApplicationController
  def index
      @http_verbs = {}
      @object_types = {}
  end
end
