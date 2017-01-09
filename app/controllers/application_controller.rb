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
	end
end