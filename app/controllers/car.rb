class CarController < ApplicationController
	get "/" do
		Car.all.to_json
	end	

	get "/cars" do
		cars = Car.all
		[:title, :car_name,:years_car, :owner].each do |filter|
			cars = cars.send(filter,params[filter]) if params[filter]
		end

		cars.to_json
	end
end