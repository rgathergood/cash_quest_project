require_relative( '../db/sql_runner' )

class Tag

  attr_reader(:type, :id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @type = options['type']
  end

  def save()
    sql = "INSERT INTO tags (type)
    VALUES ($1)
    RETURNING id;"
    values = [@type]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE tags
    SET
    type = $1
    WHERE id = $2;"
    values = [@type, @id]
    SqlRunner.run(sql, values)
  end

  def merchants()
    sql = "SELECT merchants.* FROM merchants
    INNER JOIN transactions ON merchants.id = transactions.merchant_id
    WHERE tag_id = $1;"
    values = [@id]
    merchants = SqlRunner.run(sql, values)
    result = merchants.map{|merchant|Merchant.new(merchant)}
    return result
  end

  def total()
    sql = "SELECT SUM(amount) FROM transactions
    INNER JOIN tags on tags.id = transactions.tag_id
    WHERE tag_id = $1;"
    values = [@id]
    total = SqlRunner.run(sql, values)
    return total.values[0].first.to_i
  end

  def self.all()
    sql = "SELECT * FROM tags;"
    results = SqlRunner.run(sql)
    return results.map {|tag| Tag.new (tag)}
  end

  def self.find(id)
    sql = "SELECT * FROM tags
    WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values).first
    tag = Tag.new(result)
    return tag
  end

  def self.delete(id)
    sql = "DELETE FROM tags
    WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tags;"
    SqlRunner.run(sql)
  end

end #end of class
