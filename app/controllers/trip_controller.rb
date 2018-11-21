class TripController < ApplicationController

	def index
		key = Rails.application.config.bart_api_key
		response = HTTParty.get("http://api.bart.gov/api/stn.aspx?cmd=stns&key=" + key + "&json=y")
		@stations = JSON.parse(response.body)["root"]["stations"]["station"]
	end

	def create
		key = Rails.application.config.bart_api_key
		response = HTTParty.get("http://api.bart.gov/api/sched.aspx?cmd=depart&orig="+params[:starting_station]+"&dest="+params[:ending_station]+"&date=now&key=" + key + "&b=2&a=2&l=1&json=y")
		@trips = JSON.parse(response.body)["root"]["schedule"]["request"]["trip"]

		@fares = @trips.first["fares"]["fare"]
		@origin = @trips.first["@origin"]
		@destination = @trips.first["@destination"]

		pp @trips
	end
end
