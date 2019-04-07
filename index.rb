require 'sinatra'
require 'sequel'

DB = Sequel.sqlite

DB.create_table :items do
  primary_key :id
  String :item
end
items = DB[:items]

get '/' do
  items.to_a.inject("") { |acc, item| acc << item.to_s }
end

post '/' do
  item = request.body
  items.insert(:item=>item)
end

delete '/:id' do
  items.where(:id => params[:id]).delete
end

not_found do
     status 404
     "Something wrong! Try to type URL correctly or call to UFO."
end
