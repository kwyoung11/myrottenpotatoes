# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
   Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /^I should see "(.*)" before "(.*)"/ do |movie1, movie2|
	pos1 = 0
	pos2 = 0
	page.all("table#movies tbody tr td[1]").each_with_index do |movie, pos|
		if movie.text == movie1
			pos1 = pos
		elsif movie.text == movie2
			pos2 = pos
		end
	end
	assert pos1 < pos2
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
	rating_list.split(", ").each do |rating|
		if !uncheck.nil?
			steps %Q{When I uncheck \"ratings_#{rating}\"} 
		else 
			steps %Q{When I check \"ratings_#{rating}\"}
		end
	end
end

Then /^I should not see "(.*)" in the ratings column/ do |rating|
	page.all("table#movies tbody tr td[2]").each do |rating_text|
		if page.respond_to? :should
    	page.should have_selector('table#movies tbody tr td[2]', text: rating_text)
  	else
    	assert rating_text.has_no_content?(/<td>#{rating}/)
  	end
	end
end

Then /I should see "(.*)" in the ratings column/ do |rating|
	if page.respond_to? :should
    page.should have_content(rating)
  else
    assert page.has_content?(rating)
  end
end

Then /^I should see (.*) movies/ do |selector|
	movie_count = Movie.all.count
	if selector == "all"
		num_movies_listed = page.all("table#movies tbody tr td[2]").count 
		assert num_movies_listed == movie_count
	elsif selector == "no"
		num_movies_listed = page.all("table#movies tbody tr td[2]").count 
		debugger
		assert num_movies_listed == movie_count
	else
		false
	end
end

