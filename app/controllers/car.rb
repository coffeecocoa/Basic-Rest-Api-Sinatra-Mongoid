require "./car_serializer"

class CarController < ApplicationController
	get "/api" do
		Car.all.to_json
	end	

	get "/api/cars" do
		cars = Car.all
		[:title, :car_name,:years_car, :owner].each do |filter|
			cars = cars.send(filter,params[filter]) if params[filter]
		end

		cars.map { |car| CarSerializer.new(car) }.to_json
	end
end