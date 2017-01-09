require "./config/environment"

class ApplicationController < Sinatra::Base
	configure do
		enable :sessions,:logging
		set :session_secret, "suuperdupersecret"
	end

	before do
		content_type "application/json"
		#request.session_options[:skip] = true
	end

	get "/" do
		"Welcome to Car lists"
	end

	helpers do
		def base_url
			@base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
		end

		def json_params
			begin
				JSON.parse(request.body.read)
			rescue 
				halt(400,{message: 'Invalid JSON'}.to_json)
			end
		end

		# Using a method to access the car can save us
	    # from a lot of repetitions and can be used
	    # anywhere in the endpoints during the same
	    # request
	    def car 
	    	@car ||= Car.where(id: params[:id]).first
	    end

	    def halt_if_not_found!
	    	halt(404,{message: "Car not found"}.to_json) unless car
	    end

	    def serialize(car)
	    	CarSerializer.new(car).to_json
	    end
	end
end