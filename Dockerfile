FROM ubuntu
MAINTAINER Svtplay https://github.com/Svtplay/download
# Thanx to https://github.com/mbergek/svtrecord


RUN apt-get update \
  && apt-get install -y phantomjs \
  && apt-get install -y ffmpeg \
  && apt-get install -y ruby \
  && gem install phantomjs

COPY *.rb /

RUN mkdir /downloads
EXPOSE 8066/tcp
ENTRYPOINT ["webserver.rb"]
CMD ["/bin/bash"]

