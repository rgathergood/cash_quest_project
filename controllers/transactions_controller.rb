require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/merchant.rb')
require_relative( '../models/category.rb')

get '/transactions' do
  @transactions = Transaction.all()
  @total = Transaction.total()
  erb(:"transactions/index")
end

post '/transactions' do
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:"transactions/create")
end

get '/transactions/new' do
  @merchants = Merchant.all()
  @categories = Category.all()
  erb(:"transactions/new")
end

get '/transactions/:id' do
  @transaction = Transaction.find(params[:id].to_i)
  erb(:"transactions/show")
end

get '/transactions/month/:month' do
  @transactions = Transaction.all()
  @total = Transaction.month_total(params[:month])
  erb(:"transactions/month")
end

post '/transactions/:id/edit' do
  @merchants = Merchant.all()
  @categories = Category.all()
  @transaction = Transaction.find(params[:id].to_i)
  erb(:"transactions/edit")
end

post '/transactions/:id' do
  transaction = Transaction.new(params)
  transaction.update()
  redirect to "/transactions/#{params['id']}"
end

post '/transactions/:id/delete' do
  @transaction = Transaction.find( params[:id].to_i )
  @transaction.delete()
  erb(:"transactions/confirm_delete")
end
