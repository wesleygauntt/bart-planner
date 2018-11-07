class TripController < ApplicationController
	def index
		key = Rails.application.config.bart_api_key
		response = HTTParty.get("http://api.bart.gov/api/stn.aspx?cmd=stns&key=" + key + "&json=y")
		@stations = JSON.parse(response.body)["root"]["stations"]["station"]
	end
end
