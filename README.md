[dicoding_class]: https://www.dicoding.com/academies/199
[project_starter]: https://github.com/dicodingacademy/a199-flutter-expert-project
[tmdb]: https://developers.themoviedb.org/3

# dicoding_flutter_expert

This repo is a submission task from [dicoding.com Flutter Expert class][dicoding_class].

Links:

- [Project Starter (ditonton App)][project_starter]
- [TMDb (The API used by the project)][tmdb]

# First Task

Add TV show feature on [ditonton App][project_starter]

## Task Requirements

### 1. TV Show List Page

- Displaying a list of TV shows on the available page (Homepage) or creating a new page is allowed.
- On-air, popular, and the top rated list included.
- Each category list (On air, etc...) is separated.

### 2. TV Show Detail Page

- Get TV Show Detail by the selected item on the list.
- Poster, title, rating, and overview included.
- The detail page should show other TV show recommendations.

### 3. Search TV Show

- There is a feature to search for TV show titles.  
  (API Query not Internal Query)s

### 4. TV Show Watchlist

- Users can save TV shows to a watchlist.
- The app can display Watchlisted TV shows.

### 5. Automated Testing Included

- the TV show features must-have unit testing with a minimum testing coverage of 70%.

- How to Testing Coverage:

  - Install lcov:
    - For **Linux** user, run the command below at terminal:
      ```
      sudo apt-get update -qq -y
      sudo apt-get install lcov -y
      ```
    - For **Mac** user, run the command below at terminal:
      ```
      brew install lcov
      ```
    - For **Windows** user, follow the guide below:
      - Install [Chocolatey](https://chocolatey.org/install).
      - Then run the command below at terminal:
        ```
        choco install lcov
        ```
      - Check GENTHTML and LCOV_HOME at **System variables > Environtment Variabel**. If it's not available, you can add a new variable with a value like the following:
        | Variable | Value |
        | - | - |
        | GENTHTML | C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml |
        | LCOV_HOME | C:\ProgramData\chocolatey\lib\lcov\tools |
  - Then run the `test.sh` file with the following command in the terminal or Powershell:

    - Terminal
      ```
      test.sh
      ```
    - Powershell

      ```
      ./test.sh
      ```

    This process will generate the `lcov.info` file and `coverage folder` associated with the coverage report.

### 6. Implementing a clean architecture

The project must implement a clean architecture and divide the source code into 3 layers:

- **Domain** : Contains the main requirements and logic related to business & application requirements.
- **Data** : Contains code implementation to get data from external sources.
- **Presentation** : Contains the implementation of widgets, application views, and state management.

## Optional Task

### 1. Seasons and Episode Info Included

### 2. Integration and Widget Test Included
