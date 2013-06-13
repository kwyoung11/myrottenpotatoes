# Given /^the movie (.+) exists/ do |movie|
# 	Movie.create!(movie)
# end

# When /^It has (*) reviews/ do |n|
# 	Movie.reviews.count
# end

# When /^its average review score is (*)/ do |score|
# 	Movie.reviews.sum / Movie.reviews.count
# end