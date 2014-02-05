#!/bin/sh

(heroku config | tail +2 | sed -e 's/^/export /' -e 's/\: */="/' -e 's/$/"/'; echo dashing start) | /bin/sh -x
