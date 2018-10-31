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

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album) }
  end


  def self.find_by_artist(artist)
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [artist]
    albums = SqlRunner.run(sql, values)
    return albums.map { |album| Album.new(album) }
  end


end
