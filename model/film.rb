require_relative('../db/sql_runner')
class Film
  attr_reader :id

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

end
