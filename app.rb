require 'rspotify'
require 'pry-byebug'
require './artists'
require './secret'

client_id = Secret::ID
client_token = Secret::TOKEN
RSpotify::authenticate(client_id, client_token)

artists = Artist::ARTISTS
artists_on_spotify = []
artists_batch = artists.each_slice(50).to_a

artists_batch.each do |sub_array|
  sleep 5
  sub_array.each do |artist|
    artist_exists = RSpotify::Artist.search(artist)
    artists_on_spotify << artist_exists unless artist_exists.empty?
  end
end

puts artists_on_spotify.count
