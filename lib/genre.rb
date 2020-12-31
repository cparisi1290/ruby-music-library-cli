require 'pry'

class Genre
    
    attr_accessor :name, :song, :artist

    extend Concerns::Findable

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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

    def songs
        @songs
    end

    def artists
        songs.map {|song| song.artist}.uniq
    end
end