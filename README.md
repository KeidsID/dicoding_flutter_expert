[dicoding_class]: https://www.dicoding.com/academies/199
[project_starter]: https://github.com/dicodingacademy/a199-flutter-expert-project
[tmdb]: https://developers.themoviedb.org/3

# dicoding_flutter_expert

[![Codemagic build status](https://api.codemagic.io/apps/6391f28a6945b09170773baa/6391f28a6945b09170773ba9/status_badge.svg)](https://codemagic.io/apps/6391f28a6945b09170773baa/6391f28a6945b09170773ba9/latest_build)

This repo is a submission task from [dicoding.com Flutter Expert class][dicoding_class].

Links:

- [Project Starter (ditonton App)][project_starter]
- [TMDb (The API used by the project)][tmdb]

# TODO 1

Mandatory Tasks:

- [x] TV Show List Page.
- [x] TV Show Detail Page with Recommendations.
- [x] Search TV Show Feature.
- [x] TV Show Watchlist/Bookmark Feature.
- [x] Unit testing for every Tv Show feature with min. 70% coverage.
- [x] Implementing a clean architecture.

Optional Tasks:

- [ ] TV Show Episodes & Seasons Detail.
- [ ] Widget test.
- [ ] Integration test.

# TODO 2

Mandatory Tasks:

- [x] Implementing Continuous Integration.
- [ ] Migrate state management from provider to BLoC.
- [ ] Implementing SSL Pinning.
- [ ] Integration with Firebase Analytics & Crashlytics

Optional Tasks:

- [x] Modularization (Movie & Tv Show)

# First Tasks

Add TV show feature on [ditonton App][project_starter].

## Task Requirements

### 1. TV Show List Page

- Displaying a list of TV shows on the available page (Homepage) or creating a new page is allowed.
- Airing today, popular, and the top rated list included.
- Each category list is separated.
- Each category also has its own page (Including airing today)

### 2. TV Show Detail Page

- Get TV Show Detail by the selected item on the list.
- Poster, title, rating, and overview included.
- The detail page should show other TV show recommendations.

### 3. Search TV Show

- There is a feature to search for TV show titles  
  (API Query not Internal Query).

### 4. TV Show Watchlist

- Users can save TV shows to a watchlist.
- The app can display Watchlisted TV shows.

### 5. Automated Testing Included

- **Every** TV show features **must-have unit testing** with a minimum testing coverage of 70%.

- How to check testing coverage:

  - Generate **lcov.info**:

    ```
    flutter test --coverage
    ```

  - [Then guide display lcov.info](https://stackoverflow.com/a/53663093):

    - [test_cov_console package](https://pub.dev/packages/test_cov_console):

      - Install globally
        ```
        flutter pub global activate test_cov_console
        ```
      - Run globally (Need lcov.info)
        ```
        flutter pub global run test_cov_console
        ```

    - Using lcov:

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

      - Then run command below

        ```
        genhtml coverage/lcov.info -o coverage/html
        ```

        or

        ```
        # For cmd
        tesh.sh

        # For gitbash, etc.
        ./test.sh
        ```

      - [genhtml not found issue](https://stackoverflow.com/questions/62184806/how-to-view-code-coverage-as-html-in-windows)

### 6. Implementing a clean architecture

The project must implement a clean architecture and divide the source code into 3 layers:

- **Domain** : Contains the main requirements and logic related to business & application requirements.
- **Data** : Contains code implementation to get data from external sources.
- **Presentation** : Contains the implementation of widgets, application views, and state management.

## Optional Task

### 1. Seasons and Episodes Detaiil Info Included.

### 2. Integration and Widget Test Included.

# Second Tasks

Implementing what we've learned (CI, BLoC, SSL Pinning, and Firebase Analytics & Crashlytics).

## Task Requirements

### 1. Implementing Continuous Integration

- Auto run app tests every time there is latest push to the repo.
- Display the build status badge in the GitHub repository readme file.
- Free to use any CI Service for this task.

### 2. Using BLoC Library

- Migrate state management from provider to BLoC.

### 3. Implementing SSL Pinning

- Installing an SSL certificate on the application as an additional layer of security for accessing data from the API.

### 4. Integration with Firebase Analytics & Crashlytics

- Ensuring developers continue to receive feedback from users, especially regarding stability and error reports.

## Optional Task

### 1. Modularization

- Dividing the application into modules for at least two features (Movie & Tv Show).
