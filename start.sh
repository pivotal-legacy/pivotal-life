#!/bin/sh

(cf env pivotal-life | tail +3 | sed -e 's/^/export /' -e 's/\: */="/' -e 's/$/"/'; echo dashing start) | /bin/sh -x
