require_relative('../db/sql_runner')
class Film
  attr_writer :title, :price
  attr_reader :id, :price
  def initialize(option)
    @id = option['id'].to_i if option['id']
    @title = option['title']
    @price = option['price'].to_i
  end

  def save()
      sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
      values = [@title, @price]
      array_of_hashes_film = SqlRunner.run(sql, values)
      @id = array_of_hashes_film[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM films"
    array_of_hashes_film = SqlRunner.run(sql)
    return array_of_hashes_film.map{|film| Film.new(film)}
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    array_of_hashes_film = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE tickets.film_id = $1"
    values = [@id]
    customer = SqlRunner.run(sql, values)
    return customer.map{|customer| Customer.new(customer)}
  end

  def number_of_customers
    customers.length
  end
end
