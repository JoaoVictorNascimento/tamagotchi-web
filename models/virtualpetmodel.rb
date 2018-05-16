require 'mongoid'

# Models
class VirtualPetModel
	include Mongoid::Document

	field :user, type: BSON::ObjectId
	field :petType, type: String
	field :name, type: String
	field :happy, type: Integer
	field :health, type: Integer
	field :hunger, type: Integer
	field :weight, type: Integer
	field :higiene, type: Integer
	field :birthday, type: DateTime
	field :lastTime, type: DateTime
	field :age, type: Integer
	field :state, type: String
end