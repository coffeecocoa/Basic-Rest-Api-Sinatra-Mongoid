require "./config/environment"

class ApplicationController < Sinatra::Base
	configure do
		#enable :sessions
		set :session_secret, "suuperdupersecret"
	end

	before do
		content_type "application/json"
	end

	get "/" do
		"Welcome to Car lists"
	end
end