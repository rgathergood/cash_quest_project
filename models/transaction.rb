require_relative( '../db/sql_runner' )

class Transaction

  attr_reader(:amount, :date, :merchant_id, :category_id, :id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_i
    @date = options['date']
    @merchant_id = options['merchant_id'].to_i
    @category_id = options['category_id'].to_i
  end

  def save()
    sql = "INSERT INTO transactions
    (
    amount,
    date,
    merchant_id,
    category_id
    )
    VALUES
    (
      $1, $2, $3, $4
    )
      RETURNING id;"
      values = [@amount, @date, @merchant_id, @category_id]
      results = SqlRunner.run(sql, values)
      @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE transactions
    SET
    (amount, date, merchant_id, category_id) = ($1, $2, $3, $4)
    WHERE id = $5;"
    values = [@amount, @date, @merchant_id, @category_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.total()
    sql = "SELECT SUM(amount) FROM transactions;"
    values = []
    transactions = SqlRunner.run(sql, values)
    return transactions.values[0].first.to_i
  end

  def self.month_total(month)
    sql = "SELECT SUM(amount) FROM transactions
    WHERE EXTRACT(month FROM date) = $1;"
    values = [month]
    transactions = SqlRunner.run(sql, values)
    return transactions.values[0].first.to_i
  end

  def self.month(month)
    sql = "SELECT * FROM transactions
    WHERE EXTRACT(month FROM date) = $1;"
    values = [month]
    transactions = SqlRunner.run(sql, values)
    result = transactions.map{|transaction| Transaction.new(transaction)}
    return result
  end

  def merchant()
    sql = "SELECT * FROM merchants
    WHERE id = $1;"
    values = [@merchant_id]
    results = SqlRunner.run(sql, values)
    return Merchant.new(results.first)
  end

  def category()
    sql = "SELECT * FROM categories
    WHERE id = $1;"
    values = [@category_id]
    results = SqlRunner.run(sql, values)
    return Category.new(results.first)
  end

  def self.all()
    sql = "SELECT * FROM transactions;"
    results = SqlRunner.run(sql)
    return results.map {|transaction| Transaction.new (transaction)}
  end

  def self.find(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values).first
    transaction = Transaction.new(result)
    return transaction
  end

  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values).first
    transaction = Transaction.new(result)
    return transaction
  end

  def uk_date()
    return Date.parse(@date).strftime("%d/%m/%Y")
  end

  def month()
    return Date.parse(@date).strftime("%m")
  end

end
