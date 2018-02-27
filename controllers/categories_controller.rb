require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/category.rb')

get '/categories' do
  @categories = Category.all()
  erb(:"categories/index")
end

get '/categories/new' do
  erb(:"categories/new")
end

post '/categories' do
  if(!Category.check_exists(params["type"]))
    @category = Category.new(params)
    @category.save()
    erb(:"categories/create")
  else
    erb(:"categories/create_error")
  end
end

get '/categories/:id' do
  @category = Category.find(params[:id].to_i)
  erb(:"categories/edit")
end

post '/categories/:id' do
  category = Category.new(params)
  category.update()
  redirect to "/categories"
end

post '/categories/:id/delete' do
  category = Category.find( params[:id].to_i )
  category.delete()
  erb(:"categories/confirm_delete")
end
