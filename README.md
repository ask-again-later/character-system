# README

This is the source for the Ask Again Later Character System, an application to manage characters and game data for the live-action roleplaying game [Ask Again Later](http://askagainlater.com/). The live version can be found [here](http://characters.askagainlater.com/).

## System Requirements

* Ruby 2.4
* Rails 5.0.1
* Postgresql

## How to Set Up

1. `git clone` the repository to your local drive. If you have a rails version manager, such as [RVM](http://rvm.io), either set your version to 2.4.0, or download and install 2.4.0 using `rvm install`.
2. `cd` into the project directory and run `bundle install`.
3. Run `rake db:create` and `rake db:seed` to create the database and set it up with seed data. Check the **seeds.rb** file for a list of test accounts you can use to log in.
4. Run `thin start` to start the server, and then go to http://localhost:3000/ to view your local development version of the site.

## Deployment

Deployment is handled through [Heroku](http://heroku.com/) on the free tier. New pull requests will be auto-deployed to a test application in our Heroku deployment pipeline; check your pull request for details once it's been created. Test applications are clean copies of the application meant for testing your work in an isolated environment.

Once pull requests are merged to master, they are then deployed to the staging application. Changes to staging may then be promoted to production via the Heroku dashboard.

## Review Process

When you submit a pull request for review, mention which issues you're closing in the first line (e.g. Closes #65), which will auto-close the issue when it's merged. Please make the PR title descriptive.

Request at least one reviewer to look at your pull request. If your review is requested, go to the test application and check whether the feature is working or if there's anything out of place. If you note anything, leave a comment, with screenshots if there is a visual bug. If the pull request seems fine, merge it.

Merging a pull request, as mentioned above, will automatically deploy the changes to master to the staging application. Please also re-check the changes once they have been deployed to staging, in the event of any integration issues.

If all seems clear on staging, then staging may be promoted to production. When promoting to production, also keep in mind that you may need to run any new database migrations with `heroku run rake db:migrate`.

## Project Management

finish later

## Release Organization

finish later
