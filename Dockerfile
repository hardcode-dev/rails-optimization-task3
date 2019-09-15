FROM ruby:2.6.3

RUN apt-get update &&  \
        apt-get install g++ valgrind net-tools tmux -y \
        massif-visualizer \
        --no-install-recommends \
        && apt-get install -y postgresql postgresql-contrib \
        && apt-get install sudo \
        && apt-get purge --auto-remove -y curl \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /src/*.deb

RUN groupadd -r massif && useradd -r -g massif massif \
    && mkdir -p /home/massif/test && chown -R massif:massif /home/massif
USER massif
WORKDIR /home/massif/test

RUN gem install bundler
COPY Gemfile /home/massif/test
COPY Gemfile.lock /home/massif/test
RUN bundle install