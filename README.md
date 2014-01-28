[![Build Status](https://travis-ci.org/spilth/pivotal-life.png?branch=master)](https://travis-ci.org/spilth/pivotal-life) [![Dependency Status](https://gemnasium.com/spilth/pivotal-life.png)](https://gemnasium.com/spilth/pivotal-life) [![Coverage Status](https://coveralls.io/repos/spilth/pivotal-life/badge.png)](https://coveralls.io/r/spilth/pivotal-life)

# Pivotal Life

A dashboard for Pivots at the office.

## Running Locally

To run the status board locally, do the following:

    $ git clone git@github.com:spilth/pivotal-life.git
    $ cd pivotal-life
    $ bundle
    $ cp .env{.dist,}

Open the `.env` from the last line above and customize to your liking.

Don't check that file into version control.

Start up Dashing:

    $ dashing start

Then navigate to <http://localhost:3030/>.

## Running on Heroku

    $ heroku apps:create myapp
    $ heroku config:set LATITUDE=<your lat>
    $ heroku config:set LONGITUDE=<your long>
    $ heroku config:set FORECAST_API_KEY=<your forecast.io api key>
    $ heroku config:set EVENT_CALENDAR_URL=<your google calendar xml url>
    $ heroku config:set TWITTER_CONSUMER_KEY=<your twitter consumer key>
    $ heroku config:set TWITTER_CONSUMER_SECRET=<your twitter consumer secret>
    $ heroku config:set TWITTER_OAUTH_TOKEN=<your twitter oauth token>
    $ heroku config:set TWITTER_OAUTH_SECRET=<your twitter oauth secret>
    $ git push heroku master

Check out http://shopify.github.com/dashing for more information.

## Resources

- [Pivotal Tracker Project](https://www.pivotaltracker.com/s/projects/950406)
- [Dashing](http://shopify.github.com/dashing)


