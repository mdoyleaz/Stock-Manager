FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

# Creates /app folder on container, and moves into that folder
RUN mkdir /app
WORKDIR /app

# Copys Gemfiles into container
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Installs rails
RUN bundle install

# Copies all files in directory to container
COPY . /app
