require 'mongoid'

# Models
class VirtualPetModel
	include Mongoid::Document

	field :user, type: BSON::ObjectId
	field :petType, type: String
	field :name, type: String
	field :happy, type: Float
	field :sleep, type: Float
	field :health, type: Float
	field :hunger, type: Float
	field :weight, type: Float
	field :higiene, type: Float
	field :birthday, type: DateTime
	field :lastTime, type: DateTime
	field :age, type: Float
	field :sleeping, type: Boolean
	field :state, type: String
end