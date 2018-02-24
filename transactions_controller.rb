require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( 'models/transaction.rb' )
require_relative( 'models/merchant.rb')
require_relative( 'models/tag.rb')

get '/cash-quest' do
  @transactions = Transaction.all()
  erb( :index )
end
