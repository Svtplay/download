#!/bin/bash
cd /downloads
ruby -E ISO-8859-1:UTF-8 /data/svtrecord.rb -u $1 > /downloads/svtdownload.$$.pid.log 2>&1
chmod +w /downloads/svtdownload.$$.pid.log
chmod +w /downloads/*.mp4


