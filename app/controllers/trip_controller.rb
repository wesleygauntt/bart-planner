class TripController < ApplicationController

	before_action :set_google_maps_key
	before_action :set_bart_api_key
	before_action :set_routes, only: :index
	before_action :set_stations, only: :index

	def index
		# puts @stations
	end

	def create

		response = HTTParty.get("http://api.bart.gov/api/sched.aspx?cmd="+params[:schedule_type]+"&orig="+params[:starting_station]+"&dest="+params[:ending_station]+"&date=now&key=" + @bart_api_key + "&b=2&a=2&l=1&json=y")
		@trips = JSON.parse(response.body)["root"]["schedule"]["request"]["trip"]

		@fares = @trips.first["fares"]["fare"]
		@origin = @trips.first["@origin"]
		@destination = @trips.first["@destination"]
	end

	private

	def set_google_maps_key
		@gmap_key = Rails.application.config.google_maps_api_key
	end

	def set_bart_api_key
		@bart_api_key = Rails.application.config.bart_api_key
	end

	def set_routes
		# consider storing/seeding/updating via dynamo
		response = HTTParty.get("http://api.bart.gov/api/route.aspx?cmd=routeinfo&route=all&key=" + @bart_api_key + "&json=y")
		@routes = JSON.parse(response.body)["root"]["routes"]["route"]
		@routes_as_json = @routes.to_json

		pp @routes
	end

	def set_stations
		# consider storing/seeding/updating via dynamo
		response = HTTParty.get("http://api.bart.gov/api/stn.aspx?cmd=stns&key=" + @bart_api_key + "&json=y")
		@stations = JSON.parse(response.body)["root"]["stations"]["station"]
		@stations_as_json = @stations.to_json

		# binding.pry
	end

	def set_station_hash_map
		@station_hash = {}

		@stations.each do |station|
			@station_hash[station["abbr"]] = station
		end
	end

end
