# A docker image capable of downloading videos from [svtplay.se](http://svtplay.se)

## Start container

docker run -d  -p 8066:8066 -v /my_local_exixting_dir:/downloads svtplay/download

Will download an mp4 video in best quality (2796kbps)
The file will end up in : /my_local_exixting_dir
A work log file of will be placed there as well (called: svtdownload.3782.pid.log)

## Usage 

[http://localhost:8066](http://localhost:8066)

## Extra

Soon

