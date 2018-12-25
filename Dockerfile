FROM javister-docker-docker.bintray.io/javister/javister-docker-ruby:2.1
MAINTAINER Viktor Verbitsky <vektory79@gmail.com>

COPY files /

ENV BASE_RPMLIST="$BASE_RPMLIST libffi.x86_64 git" \
    BUILD_RPMLIST="$BUILD_RPMLIST libffi-devel.x86_64 " \
    SET_GIT_PROXY="yes" \
    USER_HOME="/config"

RUN . /usr/local/bin/yum-proxy && \
    echo "*** Hack for libffi-devel" && \
    cd /usr/share/info && \
    echo "Dummy file" >> libffi.info && \
    echo "INFO-DIR-SECTION Basics" >> libffi.info && \
    echo "START-INFO-DIR-ENTRY" >> libffi.info && \
    echo "END-INFO-DIR-ENTRY" >> libffi.info && \
    echo "" >> libffi.info && \
    echo "INFO-DIR-SECTION Individual utilities" >> libffi.info && \
    echo "START-INFO-DIR-ENTRY" >> libffi.info && \
    echo "END-INFO-DIR-ENTRY" >> libffi.info && \
    echo "" >> libffi.info && \
    echo "" >> libffi.info && \
    echo "Tag Table:" >> libffi.info && \
    echo "" >> libffi.info && \
    echo "End Tag Table" >> libffi.info && \
    gzip libffi.info && \
    echo '*** Install libs' && \
    yum-install && \
    yum-install-build && \
    echo '*** Install Travis CI CLI utility' && \
    gem install travis --no-rdoc --no-ri && \
    mkdir -p /config/travis && \
    echo '*** Clean up yum caches' && \
    yum-clean-build && \
    yum-clean && \
    rm /usr/share/info/libffi.info.gz && \
    chmod --recursive +x /etc/my_init.d/*.sh /etc/service /usr/local/bin/*

ENTRYPOINT ["my_init", "--skip-runit", "--", "travis-docker"]
#CMD [""]
