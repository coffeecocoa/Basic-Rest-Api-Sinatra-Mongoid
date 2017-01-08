require "./car_serializer"

class CarController < ApplicationController
	
	#get all cars
	get "/api/cars" do
		cars = Car.all
		[:title, :car_name,:years_car, :owner].each do |filter|
			cars = cars.send(filter,params[filter]) if params[filter]
		end

		cars.map { |car| CarSerializer.new(car) }.to_json
	end

	#show details of one specific car
	get "/api/cars/:id" do |variable|
		car = Car.where(id: params[:id]).first
		halt(404,{message: "Car not found"}.to_json) unless car
		CarSerializer.new(car).to_json
	end
end