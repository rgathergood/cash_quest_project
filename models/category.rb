require_relative( '../db/sql_runner' )

class Category

  attr_reader(:type, :id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @type = options['type']
  end

  def save()
    sql = "INSERT INTO categories (type)
    VALUES ($1)
    RETURNING id;"
    values = [@type]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE categories
    SET
    type = $1
    WHERE id = $2;"
    values = [@type, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM categories
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def merchants()
    sql = "SELECT merchants.* FROM merchants
    INNER JOIN transactions ON merchants.id = transactions.merchant_id
    WHERE category_id = $1;"
    values = [@id]
    merchants = SqlRunner.run(sql, values)
    result = merchants.map{|merchant|Merchant.new(merchant)}
    return result
  end

  def total()
    sql = "SELECT SUM(amount) FROM transactions
    INNER JOIN categories on categories.id = transactions.category_id
    WHERE category_id = $1;"
    values = [@id]
    total = SqlRunner.run(sql, values)
    return total.values[0].first.to_i
  end

  def transactions()
    sql = "SELECT * FROM transactions
    WHERE category_id = $1"
    values = [@id]
    categories = SqlRunner.run(sql, values)
    result = categories.map{|category|Category.new(category)}
    return result
  end

  def self.check_exists(type)
    return Category.find_by_type(type).length != 0
  end

  def self.all()
    sql = "SELECT * FROM categories;"
    results = SqlRunner.run(sql)
    return results.map {|category| Category.new (category)}
  end

  def self.find(id)
    sql = "SELECT * FROM categories
    WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values).first
    category = Category.new(result)
    return category
  end

  def self.find_by_type(type)
    sql = "SELECT * FROM categories
    WHERE type = $1"
    values = [type]
    result = SqlRunner.run(sql, values)
    return result.map {|category| Category.new(category)}
  end

  def self.delete(id)
    sql = "DELETE FROM categories
    WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM categories;"
    SqlRunner.run(sql)
  end

end #end of class
