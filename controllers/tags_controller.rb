require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/tag.rb')

get '/tags' do
  @tags = Tag.all()
  erb(:"tags/index")
end

get '/tags/new' do
  erb(:"tags/new")
end

post '/tags' do
  @tag = Tag.new(params)
  @tag.save()
  erb(:"tags/create")
end

get '/tags/:id' do
  @tag = Tag.find(params[:id].to_i)
  erb(:"tags/edit")
end

post '/tags/:id' do
  tag = Tag.new(params)
  tag.update()
  redirect to "/tags"
end

get '/tags/:id/delete' do
  @tag = Tag.find( params[:id].to_i )
  @tag.delete()
  erb(:"tags/confirmdelete")
end
