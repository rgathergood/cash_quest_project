require_relative( '../db/sql_runner' )

class Tag

  attr_reader(:type, :id)

  def initalize(options)
    @id = options['id'].to_i if options['id']
    @type = options['type']
  end

end #end of class
