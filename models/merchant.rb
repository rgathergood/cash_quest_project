require_relative( '../db/sql_runner' )

class Merchant

  attr_reader(:name, :id)

  def initalize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

end #end of class
