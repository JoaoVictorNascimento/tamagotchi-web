require "sinatra"

set :port, 8080

get '/teste' do
  "Hello World"
end