class MontioringSysController < ApplicationController
  def index
      @http_verbs = [{:id => 1, :name => "GET"}, {:id => 2, :name => "POST"}]
      @object_types = [{:id => 1, :name => "JSON"}, {:id => 2, :name => "SOAP"}]
  end
end
