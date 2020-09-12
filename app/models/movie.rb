class Movie < ActiveRecord::Base
    
    # self. is a class method
    def self.all_ratings
        #select a subset from DB
        #grab a single record per unique value in a certain field
        Movie.select(:rating).uniq.map { |movie| movie.rating }.sort
    end
    
    
    def self.with_ratings(ratings)
        #nil case/none selected --> show every movies
        if ratings == nil
            Movie.all
        #selected rating --> match with DB    
        else
            Movie.all.where(rating: ratings.keys)
        end
    end 
end
