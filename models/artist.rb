require_relative('../db/sql_runner')
require('pg')


class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values= [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { |artist| Artist.new(artist) }
  end

  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_album(albums)
    sql = "SELECT * FROM artists WHERE id  = $1"
    values = [albums]
    artists = SqlRunner.run(sql, values)
    return artists.map {|artist| Artist.new(artist)}
  end

  def self.delete_all()
      sql = "DELETE FROM artists"
      SqlRunner.run(sql)
    end

    def self.find(id) 
      sql = "SELECT * FROM artists WHERE id = $1"
      values = [id]
      result = SqlRunner.run(sql, values)
      artist = self.new(result.first)
      return artist
    end

end
