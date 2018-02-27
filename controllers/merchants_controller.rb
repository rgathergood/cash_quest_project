require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/merchant.rb')

get '/merchants' do
  @merchants = Merchant.all()
  erb(:"merchants/index")
end

get '/merchants/new' do
  erb(:"merchants/new")
end

post '/merchants' do
  if(!Merchant.check_exists(params["name"]))
    @merchant = Merchant.new(params)
    @merchant.save()
    erb(:"merchants/create")
  else
    erb(:"merchants/create_error")
  end
end

get '/merchants/:id' do
  @merchant = Merchant.find(params[:id].to_i)
  erb(:"merchants/edit")
end

post '/merchants/:id' do
  merchant = Merchant.new(params)
  merchant.update()
  redirect to "/merchants"
end

post '/merchants/:id/delete' do
  merchant = Merchant.find( params[:id].to_i )
  merchant.delete()
  erb(:"merchants/confirm_delete")
end
