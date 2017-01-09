# serializer is going to be a PORO (Plain-Old Ruby Object)
# with one method called as_json that will be 
# called whenever to_json is called on an instance

class CarSerializer
	def initialize(car)
		@car = car
	end

	def as_json(*)
		data = {
			id: @car.id.to_s,
			title: @car.title, 
			car_pic: @car.car_pic,
			car_name: @car.car_name,
			years_car: @car.years_car.to_s,
			owner: @car.owner
		}

		#add errors to data
		data[:errors] = @car.errors if @car.errors.any?
		data
	end
end