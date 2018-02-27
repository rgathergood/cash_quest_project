require_relative( '../db/sql_runner' )

class Merchant

  attr_reader(:name, :id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO merchants (name)
    VALUES ($1)
    RETURNING id;"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE merchants
    SET name = $1
    WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM merchants
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def tags()
    sql = "SELECT tags.* FROM tags
    INNER JOIN transactions ON tags.id = transactions.tag_id
    WHERE tag_id = $1;"
    values = [@id]
    tags = SqlRunner.run(sql, values)
    result = tags.map{|tag|Tag.new(tag)}
    return result
  end

  def transactions()
    sql = "SELECT * FROM transactions
    WHERE merchant_id = $1"
    values = [@id]
    transactions = SqlRunner.run(sql, values)
    result = transactions.map{|transactions|Transaction.new(transactions)}
    return result
  end

  def total()
    sql = "SELECT SUM(amount) FROM transactions
    INNER JOIN merchants on merchants.id = transactions.merchant_id
    WHERE merchant_id = $1;"
    values = [@id]
    total = SqlRunner.run(sql, values)
    return total.first["sum"].to_i
  end

  def self.check_exists(name)
    return Merchant.find_by_name(name).length != 0
  end

  def self.all()
    sql = "SELECT * FROM merchants;"
    results = SqlRunner.run(sql)
    return results.map {|merchant| Merchant.new (merchant)}
  end

  def self.find(id)
    sql = "SELECT * FROM merchants
    WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values).first
    merchant = Merchant.new(result)
    return merchant
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM merchants
    WHERE name = $1"
    values = [name]
    result = SqlRunner.run(sql, values)
    return result.map {|merchant| Merchant.new(merchant)}
  end

  def self.delete(id)
    sql = "DELETE FROM merchants
    WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM merchants;"
    SqlRunner.run(sql)
  end

end #end of class
