FROM ruby:3.1.2

# Pass WORKDIR environment variable form docker-compose.yml to Dockerfile
ARG WORKDIR

WORKDIR ${WORKDIR}

RUN echo "alias ll='ls -lG'" >> /root/.bashrc
RUN gem install bundler

CMD ["bash"]
