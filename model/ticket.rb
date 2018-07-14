require_relative('../db/sql_runner')
class Ticket

  def initialize(option)
    @id = option['id'].to_i if option['id']
    @customer_id = option['customer_id'].to_i
    @film_id = option['film_id'].to_i
  end

    def save
      sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
      values = [@customer_id, @film_id]
      array_of_hashes_ticket = SqlRunner.run(sql, values)
      @id = array_of_hashes_ticket[0]["id"].to_i
    end

    def self.all
      sql = "SELECT * FROM tickets"
      array_of_hashes_ticket = SqlRunner.run(sql)
      return array_of_hashes_ticket.map{|ticket| Ticket.new(ticket)}
    end
end
