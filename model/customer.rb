require_relative('../db/sql_runner')
class Customer

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
end
