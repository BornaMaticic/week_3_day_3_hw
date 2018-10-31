require("pry")
require_relative("../models/artist")
require_relative("../models/album")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new("name"=>"David Bowie")
artist1.save()
artist2 = Artist.new("name"=>"Prince")
artist2.save()
# artist1
p artist2

album1 = Album.new({"title"=>"The Best of David Bowie", "genre" => "rock", 'artist_id' => artist1.id})
album1.save()
album2 = Album.new({"title"=>"best of Prince", "genre" => "alt", 'artist_id' => artist2.id})
album2.save()

Album.all()
Artist.all()
Album.find_by_artist(artist1.id)
p Artist.find_by_album(album2.id)
