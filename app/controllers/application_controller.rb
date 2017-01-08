require "./config/environment"

class ApplicationController < Sinatra::Base
	configure do
		#enable :sessions
		set :session_secret, "suuperdupersecret"
	end

	get "/" do
		"Welcome to Car lists"
	end
end