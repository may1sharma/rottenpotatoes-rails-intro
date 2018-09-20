class Movie < ActiveRecord::Base
    def self.all_ratings  
        return Movie.select(:rating).order(:rating).map(&:rating).uniq
    end
end
