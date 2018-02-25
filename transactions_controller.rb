require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( 'models/transaction.rb' )
require_relative( 'models/merchant.rb')
require_relative( 'models/tag.rb')

get '/cash-quest' do
  @transactions = Transaction.all()
  @total = Transaction.total()
  erb(:index)
end

post '/cash-quest' do
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:create)
end

get '/cash-quest/new' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:new)
end

get '/cash-quest/:id' do
  @transaction = Transaction.find(params[:id].to_i)
  erb(:show)
end

get '/cash-quest/:id/edit' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  @transaction = Transaction.find(params[:id].to_i)
  erb(:edit)
end

post '/cash-quest/:id' do
  transaction = Transaction.new(params)
  transaction.update()
  redirect to "/cash-quest/#{params['id']}"
end

get '/cash-quest/:id/delete' do
  @transaction = Transaction.find( params[:id].to_i )
  @transaction.delete()
  erb(:confirmdelete)
end

# get '/cash-quest' do
#   @tags = Tag.all()
#   @total = Tag.total()
#   erb(:categories)
# end
