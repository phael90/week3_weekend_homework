require_relative('../db/sql_runner')
class Customer

  def initialize(option)
    @id = option['id'].to_i if option['id']
    @name = option['name']
    @funds = option['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING ID"
    VALUES = [@name @funds]
    SqlRunner.run(sql, values)
    @id = customers[0]['id'].to_i
  end
end
