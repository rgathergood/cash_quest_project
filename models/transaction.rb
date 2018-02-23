require_relative( '../db/sql_runner' )

class Transaction

  attr_reader(:amount, :merchant_id, :tag_id, :id)

  def initalize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_i
    @merchant_id = options['merchant_id'].to_i
    @tag_id = options['tag_id'].to_i
  end

end
