@block @block_myoverview @javascript
Feature: Course overview block show users their progress on courses
  In order to enable the my overview block in a course
  As a student
  I can see the progress percentage of the courses I am enrolled in

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email | idnumber |
      | teacher1 | Teacher | 1 | teacher1@example.com | T1 |
      | student1 | Student | 1 | student1@example.com | S1 |
    And the following "courses" exist:
      | fullname | shortname | category | enablecompletion | startdate     | enddate       |
      | Course 1 | C1        | 0        | 1                | ##yesterday## | ##tomorrow##  |
    And the following "activities" exist:
      | activity | course | idnumber | name          | intro                   | timeopen      | timeclose     |
      | choice   | C1     | choice1  | Test choice 1 | Test choice description | ##yesterday## | ##tomorrow##  |
    And the following "course enrolments" exist:
      | user | course | role            |
      | teacher1 | C1 | editingteacher  |
      | student1 | C1 | student         |

  Scenario: User complete activity and verify his progress
    Given I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on
    And I follow "Test choice 1"
    And I navigate to "Edit settings" in current page administration
    And I set the following fields to these values:
      | Completion tracking | Show activity as complete when conditions are met |
      | id_completionview   | 1                                                 |
    And I press "Save and return to course"
    And I log out
    And I log in as "student1"
    Then I should see "Course 1" in the "Course overview" "block"
    And I should see "0%" in the "Course overview" "block"
    And I am on "Course 1" course homepage
    And I follow "Test choice 1"
    And I follow "Dashboard" in the user menu
    And I should see "Course 1" in the "Course overview" "block"
    And I should see "100%" in the "Course overview" "block"
    And I log out