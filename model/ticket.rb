require_relative('../db/sql_runner')
class Ticket

  def initialize(option)
    @id = option['id'].to_i if option['id']
    @customer_id = option['customer_id'].to_i
    @film_id = option['film_id'].to_i
  end

    def save
      sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING ID"
      VALUES = [@customer_id, @film_id]
      SqlRunner.run(sql, values)
      @id = tickets[0]["id"].to_i
    end
end





# git commit -m"Initial commit, created files and save function"
