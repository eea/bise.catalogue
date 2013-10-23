Feature: Manage Articles

  In order to catalogue articles
  As an authenticated eionet user
  I want to create and manage articles

  Background:
    Given I am authenticated with ldap

  Scenario: Articles List
    Given I have articles titled Biodiversity, Invasive Species
    When I go to the list of articles
    Then I should see "Biodiversity"
    And I should see "Invasive Species"

  Scenario: Create article
    When I go to the list of articles
    Then I should see new article button titled "New Article"
    And I can register a new article

  Scenario: Search indexed articles
    Given I have articles titled Biodiversity, Invasive Species
    When I go to the list of articles
    And I search article "Biodiversity"
    Then I should see "Biodiversity"







