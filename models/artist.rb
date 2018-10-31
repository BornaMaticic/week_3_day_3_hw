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


  def self.find_by_album(albums)
    sql = "SELECT * FROM artists WHERE id  = $1"
    values = [albums]
    artists = SqlRunner.run(sql, values)
    return artists.map {|artist| Artist.new(artist)}
  end



end
