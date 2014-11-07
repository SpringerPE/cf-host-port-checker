Feature: Host-Port Checking
  In order to do a host:port connectivity checking easily
  As a dev
  I want to have a page that does it

  Scenario: View home page
    Given I am viewing "/"
    Then I should see "I can haz tcp check plz"

  Scenario: Checking valid TCP connectivity
    Given I am viewing "/"
    When I fill in "host" with "localhost"
    And I fill in "port" with "6667"
    And I click "Check tcp"
    Then I should see "Yes! I can reach"

  Scenario: Checking valid TCP connectivity
    Given I am viewing "/"
    When I fill in "host" with "localhost"
    And I fill in "port" with "6668"
    And I click "Check tcp"
    Then I should see "Boohoo"

  Scenario: Checking valid URL connectivity
    Given I am viewing "/"
    When I fill in "url" with "www.google.com"
    And I click "Check url"
    Then I should see "Yes! I can reach"

  Scenario: Checking an invalid URL connectivity
    Given I am viewing "/"
    When I fill in "url" with "www.domaindoesnotexist.com"
    And I click "Check url"
    Then I should see "Boohoo"

  Scenario: Checking no entries
    Given I am viewing "/"
    When I click "Check url"
    Then I should see "Stop trying to defeat the system."