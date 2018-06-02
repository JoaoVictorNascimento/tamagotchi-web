require 'mongoid'

# Models
class UserModel
	include Mongoid::Document

    field :username, type: String
    field :password, type: String
    field :cash, type: Integer
end