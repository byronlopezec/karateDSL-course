@home
Feature: Test for the home page

    Background: Define URL:
        Given url 'https://api.realworld.io/api/'

    Scenario: Get all tags
        # Given url 'https://api.realworld.io/api/'
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['welcome']
        And match response.tags !contains ['implementation']
        And match response.tags contains any ['frontend', 'backend','welcome']
        # And match response.tags contains only ['welcome']
        And match response.tags == "#array"
        And match each response.tags == "#string"

    Scenario: get 10 articles from the page
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        # Given param limit = 10
        # Given param offset = 0
        Given params {limit: 10, offset: 0}
        # Given url 'https://api.realworld.io/api/'
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[9]'
        And match response.articlesCount == 9
        And match response.articlesCount != 8
        And match response == {articles: "#array", articlesCount: 9}
        And match response == {articles: "#[9]", articlesCount: 9}
        And match response.articles[0].createdAt contains '2022'
        And match response.articles[*].favoritesCount contains 0
        And match response..bio contains null
        And match each response..following == "#boolean"
        And match each response..following == false
        And match each response..favoritesCount == "#number"
        And match each response..bios == "#string"
        And match each response.articles ==
            """
            {
                "slug": "#string",
                "title": "#string",
                "description": "#string",
                "body": "#string",
                "tagList": "#[]",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "favorited": "#boolean",
                "favoritesCount": "#number",
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": "#boolean"
                }
            }
            """