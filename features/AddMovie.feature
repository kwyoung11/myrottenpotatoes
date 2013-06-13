Feature: User can manually add movie
 
Scenario: Add a movie
  Given I am on the RottenPotatoes home page
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
  When I fill in "Title" with "Men In Black"
  And I fill in "Rating" with "PG-13"
  And I fill in "Release Date" with "04/02/99"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  And I should see "Men In Black"

  Scenario: Add a movie with no title
  Given I am on the RottenPotatoes home page
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
  When I fill in "Title" with ""
  And I fill in "Rating" with "PG-13"
  And I fill in "Release Date" with "04/02/99"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  And I should see "You left the title blank!"