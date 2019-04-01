# User Authentication

## Summary

For our user authentication, we are going to add a couple of roles, one for `Portfolio Managers` and one for `Customers`. These roles are going to possess different abilities.

#### Role Permissions

-   `Portfolio Manager`: This role is going to have write access to the database, and have the ability to modify customers accounts. This will essentially be our `Admin` role.
-   `Customer`: This role is only going to posses read access to their specific account.

* * *

## Configuring Devise

#### Installation

Location: `stock-manager/Gemfile`

To install devise we are adding the following to the Gemfile

```bash
# User Authentication
gem 'devise'
```

Followed by running the next commands to get the initial configuration out of the way.

```bash
$ docker-compose run rails bundle install && docker-compose build
```

```bash
$ docker-compose run rails rails g devise:install
```

* * *

## Generate Devise User

```bash
$ docker-compose run rails rails g devise User
```

##### Generate default Devise views

```bash
$ docker-compose run rails rails g devise:views
```

##### Run Migrations

```bash
$ docker-compose run rails rake db:migrate
```

* * *

## Creating Portfolio Manager Authentication

Create a new migration to add `Portfolio Manager` option

```bash
$ docker-compose run rails rails g migration add_manager_to_user manager:boolean
```

##### Modify default option before running migration

Location: `stock-manager/db/migrations/*_add_manager_to_user.rb`

```ruby
class AddManagerToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :manager, :boolean, default: false
  end
end
```

##### Migrate the changes

```bash
$ docker-compose run rails rake db:migrate
```

#### Create a default manager account

Location: `stock-manager/db/seeds.rb`

Add the following seed to generate a default user

```ruby
User.create(email: 'test@test.com', password: 'password', manager: true)
```

Once this is added generate the seed

```bash
$ docker-compose run rails rake db:setup
```

* * *

## Limiting access based on role

For this I decided to use a gem called `cancancan`, this will open up the ability to limit access to specific resources based on if the manager option is marked to true.

##### Adding `cancancan` gem

Location: `stock-manager/Gemfile`

```bash
# User Authentication
gem 'devise'
gem 'cancancan', '~> 2.0'
```

Then proceed by running the `bundle install` command on the container.

##### Building the `ability.rb` model

```bash
docker-compose run rails rails g cancan:ability
```

This command will generate an 'ability.rb' file in our `models` directory.

##### Adding access limits to the `ability.rb` model

Location: `stock-manager/app/models/ability.rb`

Now that we have this in place, we can add a a simple command to provide the option to allow access to specific parts of our site based on the authentication level.

```ruby
def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.manager?
      can :manage, :all
    else
      can :read, :all
    end
end
```
