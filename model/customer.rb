require_relative('../db/sql_runner')
class Customer
attr_writer :name, :funds
attr_reader :id

  def initialize(option)
    @id = option['id'].to_i if option['id']
    @name = option['name']
    @funds = option['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    array_of_hashes_customer = SqlRunner.run(sql, values)
    @id = array_of_hashes_customer[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    array_of_hashes_customer = SqlRunner.run(sql)
    return array_of_hashes_customer.map{ |customer| Customer.new(customer) }
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    array_of_hashes_customer = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)

  end

  # def delete_all()
  #   sql = "DELETE * FROM customers"
  # end
end
