ENV['SINATRA_ENV'] ||= "development"

require "bundler/setup"
Bundler.require(:default, ENV['SINATRA_ENV'])

#db setup
Mongoid.load!("./db/mongoid.config")


require_all 'app'