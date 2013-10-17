# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## This will add the verbs to verbs table
#verb = Verb.first
#Verb.create([{ name: "GET"},{ name: "POST"},{ name: "DELETE"},{ name: "PUT"}]) if verb.blank?

#request_object = RequestObjectType.first
#RequestObjectType.create([{ name: "JSON"},{ name: "SOAP"}]) if request_object.blank?

a = HTTParty.get("http://gdata.youtube.com/feeds/api/playlists/56D792A831D0C362/?v=2&alt=json&feature=plcp")
UrlRequestResponse.create(:url => "http://gdata.youtube.com/feeds/api/playlists/56D792A831D0C362/?v=2&alt=json&feature=plcp", :http_verb => "GET", :timeout => "30", :object_type => "JSON", :time_to_run => Time.now, :expected_response_header => '{"server"=>["nginx"], "date"=>["Thu, 17 Oct 2013 11:02:13 GMT"], "content-type"=>["text/html; charset=utf-8"], "transfer-encoding"=>["chunked"], "connection"=>["close"], "status"=>["406 Not Acceptable"], "x-xss-protection"=>["1; mode=block"], "x-content-type-options"=>["nosniff"], "x-frame-options"=>["SAMEORIGIN"], "x-ua-compatible"=>["IE=Edge,chrome=1"], "cache-control"=>["no-cache"], "set-cookie"=>["remember_token=; path=/; expires=Fri, 17-Oct-2014 11:02:13 GMT; secure"], "x-request-id"=>["67244b96a3f4366858a28e47dc829a87"], "x-runtime"=>["0.009315"], "x-rack-cache"=>["miss"]}', :expected_response_body => a.body.to_s)
a = HTTParty.get("http://rubygems.org/api/v1/some_api_call.json")
UrlRequestResponse.create(:url => "http://rubygems.org/api/v1/some_api_call.json", :http_verb => "GET", :timeout => "30", :object_type => "JSON", :time_to_run => Time.now, :expected_response_header => a.headers.to_s, :expected_response_body => a.body.to_s)
a = HTTParty.post("http://rubygems.org/api/v1/gems/httparty/owners")
UrlRequestResponse.create(:url => "http://rubygems.org/api/v1/gems/httparty/owners", :http_verb => "GET", :timeout => "30", :object_type => "JSON", :time_to_run => Time.now, :expected_response_header => a.headers.to_s, :expected_response_body => a.body.to_s, :request_header => "{'Content-Type' => 'application/json'}", :request_body => "{ :email => 'hello@gmail.com'}")
a = HTTParty.get("http://gdata.youtube.com/feeds/api/playlists/56D792A831D0C362/?v=2&alt=json&feature=plcp")
UrlRequestResponse.create(:url => "http://rubygems.org/api/v1/gems/httparty/owners", :http_verb => "GET", :timeout => "30", :object_type => "JSON", :time_to_run => Time.now, :expected_response_header => a.headers.to_s, :expected_response_body => a.body.to_s, :request_header => "{'Content-Type' => 'application/json'}", :request_body => "{ :email => 'hello@gmail.com'}")


