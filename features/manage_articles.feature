Feature: Manage Articles
  In order to catalogue articles
  As an authenticated eionet user
  I want to create and manage articles

  Background:
    Given Countries and languages are imported
    And I am authenticated with ldap
    And I'm allowed in "BISE" library

  @javascript
  Scenario: Articles List
    Given I have article titled "Green Infrastructure"
    When I go to the list of articles
    Then I should see "Green Infrastructure"

  Scenario: Create article
    When I go to the list of articles
    Then I should see a button titled "New Article"
    And I can register a new article

  Scenario: Search indexed articles
    Given I have article titled "Biodiversity"
    When I go to the list of articles
    And I search article "Biodiversity"
  #   Then I should see "Biodiversity"


