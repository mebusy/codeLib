#!bash

set -e

# if chromium is not running, start it
if ! pgrep -x "chromium" > /dev/null
then
    exec --no-startup-id chromium
fi
