FROM ubuntu
MAINTAINER Svtplay https://github.com/Svtplay/download

# Thanx to https://github.com/mbergek/svtrecord
# Thanx to https://github.com/wernight/docker-phantomjs

RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
	ffmpeg \
	curl \
	ruby \
	ca-certificates \
        bzip2 \
        libfontconfig \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN set -x \
 && mkdir /tmp/phantomjs \
 && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
        | tar -xj --strip-components=1 -C /tmp/phantomjs \
 && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin \
    # Install dumb-init (to handle PID 1 correctly).
    # https://github.com/Yelp/dumb-init
 && curl -Lo /tmp/dumb-init.deb https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64.deb \
 && dpkg -i /tmp/dumb-init.deb \
    # Clean up
 && rm -rf /tmp/* /var/lib/apt/lists/* \
    \
    # Run as non-root user.
 && useradd --system --uid 72379 -m --shell /usr/sbin/nologin phantomjs \
 && su phantomjs -s /bin/sh -c "phantomjs --version" \
 && gem install phantomjs \
 && mkdir /downloads \
 && mkdir /data

COPY *.rb /data/
COPY *.sh /data/
COPY *.html /data/

RUN /data/run_things.sh 'cat /etc/*release' \
        'curl --version' \
        'ruby -v' \
        'ffmpeg -version' \
        'phantomjs -v' \
        'env'   \
         > /data/info.txt \
 && chown phantomjs /downloads \
 && chown -R phantomjs /data

USER phantomjs

# ruby -E ISO-8859-1:UTF-8

EXPOSE 8910
EXPOSE 8066/tcp
#ENTRYPOINT ["webserver.rb"]
CMD ["/bin/bash"]

