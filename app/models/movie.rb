class Movie < ActiveRecord::Base
attr_accessible :title, :rating, :release_date, :actors
	def self.ratings
		@all_ratings = ['G','PG','PG-13','R']
	end

end
