require_relative('../db/sql_runner')
class Film

  def initialize(option)
    @id = option['id'].to_i if option['id']
    @title = option['title']
    @price = option['price'].to_i
  end

  def save()
      sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING ID"
      VALUES = (@title, @price)
      SqlRunner.run(sql, values)
      @id = films[0]['id'].to_i
  end

end
