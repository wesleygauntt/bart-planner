class TripController < ApplicationController
	def index
		response = HTTParty.get("http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V&json=y")
		@stations = JSON.parse(response.body)["root"]["stations"]["station"]
	end
end
