require 'mongoid'

# DB Setup
Mongoid.load!("./models/mongoid.config", :production)

# Models
class VirtualPetModel
	include Mongoid::Document

	field :user, type: BSON::ObjectId
	field :name, type: String
	field :happy, type: Integer
	field :health, type: Integer
	field :hunger, type: Integer
	field :higiene, type: Integer
	field :birthday, type: Date
	field :age, type: Integer
	field :state, type: String

end