#!/bin/sh
#
# Start processes by using supervisord
#
#
TD_AGENT_LOG=/var/log/td-agent/td-agent.log
touch $TD_AGENT_LOG
supervisord
tail -f $TD_AGENT_LOG
