# Initial Setup

### Build Dockerfiles

#### Create `docker-compose.yml`

Location: `./docker-compose.yml`

Create two services, one for rails and one for our postgresql database.

```yaml
version: '3'
services:
  stock_db:
    image: postgres
  rails:
    depends_on:
      - stock_db
    build:
      context: ./stock-manager
      dockerfile: 'Dockerfile'
    volumes:
        - ./stock-manager/:/app
    ports:
      - "3000:3000"
    command: bundle exec rails s -p 3000 -b '0.0.0.0'
```

#### Create rails Dockerfile

Location: `stock-manager/Dockerfile`

```Dockerfile
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
```

* * *

### Configure Rails

Now that our Docker container

#### Create Gemfile

Location: `stock-manager/Gemfile`

```bash
$ echo "source 'https://rubygems.org'
gem 'rails', '~>5'" > stock-manager/Gemfile
```

#### Create Gemfile.lock

Location: `stock-manager/Gemfile.lock`

```bash
touch stock-manager/Gemfile.lock
```

#### Create new rails project in container

```bash
$ docker-compose run rails rails new . --force --no-deps --database=postgresql
```

#### Change ownership from `root` to current user

This command needs to be run locally to modify the permissions since the rails project was created as `root` in the container. Without this the contents of our rails project wont be able to be modified outside the container

```bash
$ sudo chown -R $USER:$USER stock-manager/
```

#### Rebuild container to move to new Gemfile

```bash
$ docker-compose build
```

* * *

### Setting Up Database

#### Modifications to `database.ym`

Location: `stock-manager/config/database.yml`

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  host: stock_db     # Docker container hostname
  username: postgres # Default Postgres username
  password:          # No password is configured by default
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
```

#### Start Docker Containers

```bash
$ docker-compose up
```

#### Create Database in `rails` Container

```bash
$ docker-compose run web rake db:create
```

#### Finally

Connect to `http://127.0.0.1:3000/` to make sure that everything went well and Rails is now up and running.
