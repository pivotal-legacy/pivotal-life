[![Build Status](https://travis-ci.org/spilth/pivotal-life.png?branch=master)](https://travis-ci.org/spilth/pivotal-life) [![Dependency Status](https://gemnasium.com/spilth/pivotal-life.png)](https://gemnasium.com/spilth/pivotal-life) [![Coverage Status](https://coveralls.io/repos/spilth/pivotal-life/badge.png)](https://coveralls.io/r/spilth/pivotal-life)

# Pivotal Life

A dashboard for Pivots at the office.

## Running Locally

To run the status board locally, do the following:

    $ git clone git@github.com:spilth/pivotal-life.git
    $ cd pivotal-life
    $ bundle
    $ ./start.sh

Then navigate to <http://localhost:3030/>.


To run Dashing without the environment variables:

    $ dashing start

This will still run on <http://localhost:3030/>, but it won't connect to any of the external services.


## Deploying

### Staging

    $ cf push -f staging-manifest.yml

Navigate to pivotal-life-staging.cfapps.io

### Production

    $ cf push -f manifest.yml

Navigate to pivotal-life.cfapps.io

This app is built on the Dashing framework, which is based on Sinatra.
Check out http://shopify.github.com/dashing for more information.

## Resources

- [Pivotal Tracker Project](https://www.pivotaltracker.com/s/projects/950406)
- [Dashing](http://shopify.github.com/dashing)
- PM: Michael McGinley

