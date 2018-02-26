require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/tag.rb')

get '/tags' do
  @tags = Tag.all()
  # @total = Tag.total()
  erb(:"tags/index")
end
