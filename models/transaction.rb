require_relative('../db/sql_runner')
require('date')

class Transaction
  attr_reader :id
  attr_accessor :merchant_id, :value, :tagtype_id, :date

# Constructor for Transaction class
  def initialize(transaction)
    @id = transaction['id'].to_i
    @merchant_id = transaction['merchant_id'].to_i
    @value = transaction['value'].to_i
    @tagtype_id = transaction['tagtype_id'].to_i
    @date = transaction['date']
  end

# Function to save a new record to the Transactions records in the database
  def save
    sql = "INSERT INTO transactions (merchant_id, value, tagtype_id, date)
    VALUES ($1, $2, $3, $4)
    RETURNING id;"
    values = [@merchant_id, @value, @tagtype_id, @date]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

# Function to return all records from the Transactions records in the database
  def self.all
    sql = "SELECT * FROM transactions"
    transactions_hash = SqlRunner.run(sql)
    transactions = transactions_hash.map{|transaction| Transaction.new(transaction)}
    return transactions
  end

# Function to find a record by id from the Transactions records in the database
  def self.find( id )
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )
    transaction = Transaction.new( result.first )
    return transaction
  end

# Function to update a record by id in the Transactions records in the database
  def update()
    sql = "UPDATE transactions
    SET (merchant_id, value, tagtype_id, date) = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@merchant_id, @value, @tagtype_id, @date, @id]
    SqlRunner.run( sql, values )
  end

# Function to delete a record by id in the Transactions records in the database
  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

# Function to delete all records from the Transactions records in the database
  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql)
  end

# Function to find the total transaction value from the Transactions records in the database
  def self.get_total_value()
    transactions = Transaction.all()
    total_value = 0
    transactions.each {|transaction| total_value += transaction.value}
    return total_value
  end

# Function to split the total transaction value by Tagtype from the Transactions records
  def self.get_total_values_by_tag()
    transactions = Transaction.all()
    tags = TagType.all()
    total_values_by_tag_array = []

    tags.each do |tag|
      tag_running_total = 0

      transactions.each do |transaction|
        transaction_tag = TagType.find(transaction.tagtype_id)
        if transaction_tag.type == tag.type
          tag_running_total += transaction.value
        end
      end

      tag_total_hash = {"tag_type" => tag.type, "total" => tag_running_total}
      total_values_by_tag_array.push(tag_total_hash)
    end

    return total_values_by_tag_array
  end

# Function to return an array with all the years that transcations occurred
  def self.get_transaction_years()
    transactions = Transaction.all()
    transaction_years = Array.new()

    transactions.each do |transaction|
      transaction_year = transaction.date.slice(0,4).to_i
      transaction_years.push(transaction_year)
    end
      transaction_years.uniq!
      transaction_years.sort
      transaction_years.reverse!
    return transaction_years
  end

# Function to return an array containing the transaction values split by year and month
  def self.get_spending_by_year_and_month()

    transactions = Transaction.all()
    transaction_years = Transaction.get_transaction_years()
    totals_by_year = Array.new()

    transaction_years.each do |year|
      month_totals = Array.new(12,0)
      transactions.each do |transaction|
        if transaction.date.slice(0,4).to_i == year
          transaction_month = transaction.date.slice(5,2).to_i - 1
          month_totals[transaction_month] += transaction.value
        end
      end
      yearly_totals_hash = {"year" => year, "monthly_totals" => month_totals}
      totals_by_year.push(yearly_totals_hash)
    end

    return totals_by_year

  end


end
