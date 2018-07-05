require_relative('../db/sql_runner')

class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(merchant)
    @id = merchant['id'].to_i
    @name = merchant['name']
  end
# Function to save a new record to Merchants records in the database
  def save
    sql = "INSERT INTO merchants (name)
    VALUES ($1)
    RETURNING id;"
    values = [@name]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

# Function to return all records from the Merchants records in the database
  def self.all
    sql = "SELECT * FROM merchants"
    merchants_hash = SqlRunner.run(sql)
    merchants = merchants_hash.map {|merchant| Merchant.new(merchant)}
    return merchants
  end

# Function to find a record to Merchants records in the database
  def self.find( id )
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )
    merchant = Merchant.new( result.first )
    return merchant
  end

# Function to find a record by name in the Merchants records in the database
  def self.find_by_name(name)
    sql = "SELECT * FROM merchants WHERE name = $1"
    values = [name]
    result = SqlRunner.run( sql, values )
    first_result =  result.first
    if first_result != nil
      merchant = Merchant.new( first_result )
      return merchant
    else
      return nil
    end
  end

# Function to delete all records from the Merchants records in the database
  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run( sql)
  end

# Function to delete a record by id from the Merchants records in the database
  def delete()
    sql = "DELETE FROM merchants
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

# Function to update a record by id in the Merchants records in the database
  def update()
    sql = "UPDATE merchants
    SET (name) = ($1)
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run( sql, values )
  end

end
