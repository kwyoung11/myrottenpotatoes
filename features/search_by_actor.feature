Feature: Search movies by actor/actress
	As a moviegoer
	I want to search movies by actor/actress
	So that I can find movies with my favorite actors/actresses

Background: Give the following movies exist
  Given the following movies exist:
  | title                   | rating | release_date |   actors 	 |
  | Aladdin                 | G      | 25-Nov-1992  | 					 |
  | The Terminator          | R      | 26-Oct-1984  | 					 |
  | When Harry Met Sally    | R      | 21-Jul-1989  | 					 |
  | The Help                | PG-13  | 10-Aug-2011  | Emma Stone |
  | Chocolat                | PG-13  | 5-Jan-2001   | 					 |
  | Amelie                  | R      | 25-Apr-2001  | 					 |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |						 |
  | The Incredibles         | PG     | 5-Nov-2004   |						 |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |						 |
  | Chicken Run             | G      | 21-Jun-2000  |						 |

Scenario: Search movies by actor/actress
	Given I am on the RottenPotatoes home page
	And I fill in "Search" with "Emma Stone"
	And I press "Search"
	Then I should be on the RottenPotatoes home page
	And I should see "The Help"
	And I should not see "The Terminator"
