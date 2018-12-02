class TripController < ApplicationController

	before_action :set_google_maps_key
	before_action :set_stations, only: :index

	def index
		# puts @stations
		# gtfs_latitude
		# gtfs_longitude
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

	private

	def set_google_maps_key
		@gmap_key = Rails.application.config.google_maps_api_key
	end

	def set_stations
		# consider storing/seeding/updating via dynamo


		key = Rails.application.config.bart_api_key
		response = HTTParty.get("http://api.bart.gov/api/stn.aspx?cmd=stns&key=" + key + "&json=y")
		@stations = JSON.parse(response.body)["root"]["stations"]["station"]
		@stations_as_json = @stations.to_json

	end

end
