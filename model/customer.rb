require_relative('../db/sql_runner')
require_relative('film')
class Customer
attr_writer :name, :funds
attr_reader :id, :funds

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

  def delete_all()
    sql = "DELETE * FROM customers"
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map{|film| Film.new(film)}
  end

  def buy_ticket(film)
    @funds -= film.price
    update
  end

  def customers_tickets
    sql = "SELECT * FROM tickets WHERE customer_id = 1"
    ticket = SqlRunner.run(sql)
    return ticket.map{|ticket| Ticket.new(ticket)}
  end
end
