require_relative('../db/sql_runner')
require('pg')



class Album

  attr_accessor :title, :artist_id, :genre
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO albums
    (title,
      artist_id,
      genre
    )
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@title, @artist_id, @genre]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end


  def update
      sql = "UPDATE albums SET name = $1, artist_id = $2 WHERE id = $3"
      values = [@name, @artist_id, @id]
      SqlRunner.run(sql, values)
    end


  def artist()
   sql = "SELECT * FROM artists
   WHERE id = $1"
   values = [@artist_id]
   artist = SqlRunner.run( sql,values )
   result = Artist.new( artist.first )
   return result
 end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album) }
  end


  def delete() 
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end


  def self.find_by_artist(artist)
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [artist]
    albums = SqlRunner.run(sql, values)
    return albums.map { |album| Album.new(album) }
  end


end
