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
	get "/api/cars/:id" do |variable|
		car = Car.where(id: params[:id]).first
		halt(404,{message: "Car not found"}.to_json) unless car
		CarSerializer.new(car).to_json
	end

	#create a car post
	post "/api/cars" do
		car = Car.new(json_params)
		if car.save
			response.headers["Location"] = "#{base_url}/api/cars/#{car.id}"
			status 201
		else
			status 422
			body CarSerializer.new(car).to_json
		end
	end

	#update a car post
	patch "/api/cars/:id" do
		car = Car.where(id: params[:id]).first
		halt(404,{message: "Car not found"}.to_json) unless car
		if car.update_attributes(json_params)
			CarSerializer.new(car).to_json
		else
			status 422
			body CarSerializer.new(car).to_json
		end
	end
end

