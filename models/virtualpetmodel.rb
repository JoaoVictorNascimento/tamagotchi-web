require 'mongoid'

# Models
class VirtualPetModel
	include Mongoid::Document

	field :user, type: BSON::ObjectId
	field :creator, type: String
	field :petType, type: String
	field :name, type: String
	field :happy, type: Float
	field :tiredness, type: Float
	field :health, type: Float
	field :hunger, type: Float
	field :weight, type: Float
	field :higiene, type: Float
	field :birthday, type: DateTime
	field :lastTime, type: DateTime
	field :age, type: Float
	field :sleeping, type: String
	field :state, type: String
end