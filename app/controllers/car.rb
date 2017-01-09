#require "./car_serializer"

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
	get "/api/cars/:id" do 
		halt_if_not_found!
		serialize(car)
	end

	#create a car post
	post "/api/cars" do
		car = Car.new(json_params)
		halt(422,serialize(car)) unless car.save
		response.headers["Location"] = "#{base_url}/api/cars/#{car.id}"
		status 201
	end

	#update a car post
	patch "/api/cars/:id" do
		halt_if_not_found!
		halt(422,serialize(car)) unless car.update_attributes(json_params)
		serialize(car)
	end

	#delete a car post
	delete "/api/cars/:id" do
		car.destroy if car
		status 204
	end
end

