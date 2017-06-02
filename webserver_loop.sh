#!/bin/bash
while true
do
  cd /downloads
  ruby -E ISO-8859-1:UTF-8 /data/webserver.rb 8066
  sleep 0.1
done
