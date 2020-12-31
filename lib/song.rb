require 'pry'

class Song
    
    attr_accessor :name
    attr_reader :artist, :genre


    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def self.all
        @@all
    end

    def save
        self.class.all << self
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        @@all.find {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        song = find_by_name(name)|| create(name)
    end

    def self.new_from_filename(filename)
        file = filename.split(" - ")
        artist_name, song_name = file[0], file [1]
        genre_name = file[2].gsub(".mp3", "")
        
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).tap {|song| song.save}
    end


end