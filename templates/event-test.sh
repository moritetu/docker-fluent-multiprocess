#!/bin/sh
#
# Send a few events for test
#
FLUENT_CAT=/usr/lib64/fluent/ruby/bin/fluent-cat

# Send to port 24224 with tag "debug"
echo '{"key":"24224"}'|  $FLUENT_CAT -p 24224 debug

# Send to port 24225 with tag "debug"
echo '{"key":"24225"}'|  $FLUENT_CAT -p 24225 debug
