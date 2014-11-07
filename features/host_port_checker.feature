Feature: Host-Port Checking
  In order to do a host:port connectivity checking easily
  As a dev
  I want to have a page that does it

Scenario: View home page
    Given I am viewing "/"
    Then I should see "I can haz tcp check plz"

Scenario: Checking valid TCP connectivity
  Given I am viewing "/"
  When I fill in "host" with "google.com"
  And I fill in "port" with "80"
  And I click "Check tcp"
  Then I should see "Yes! I can reach"