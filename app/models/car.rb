require "./config/environment"

class Car
	include Mongoid::Document
	include Mongoid::Timestamps

	field :title , type: String
	field :car_pic, type: String
	field :car_name, type: String
	field :years_car, type: Integer
	field :owner, type: String

	validates :title, presence: true
	validates :car_pic, presence: true
	validates :car_name, presence: true
	validates :years_car, presence: true
	validates :owner, presence: true

	#filter
	scope :title, -> (title) {where(title: /^#{title}/)}
	scope :car_name, -> (car_name) {where(car_name: /^#{car_name}/)}
	scope :years_car, -> (years_car) {where(years_car: years_car)}
	scope :owner, -> (owner) {where(owner: owner)}
end