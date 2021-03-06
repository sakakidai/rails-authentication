FROM ruby:3.1.2

# Pass WORKDIR environment variable form docker-compose.yml to Dockerfile
ARG WORKDIR

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    BUNDLE_PATH=vendor/bundle

WORKDIR ${WORKDIR}

RUN echo "alias ll='ls -lG'" >> /root/.bashrc
RUN gem install bundler

CMD ["bash"]
