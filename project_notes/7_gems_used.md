# Gems Used

I used a few Gems for this project to accomplish various tasks, here is a list and why I decided to use these.

* * *

### User Authentication

#### Devise:

I used Devise for the basic user creation and log ins, this seems to be the best option. I didn't make many changes, and there were a few extra features I was wanting to add on to it , like user creation from a `Manager` account. This is definitely something I would have applied if I had a bit more time.

#### Cancancan:

This was used to limit access to pages besides the portfolio possessed by the customer that is currently logged in. Nothing special was used here, besides this limitation and no restrictions to accounts that possessed the `manager` flag.

* * *

### Template Formatting

#### Bootstrap:

I added the bootstrap gem to make styling the templates a bit easier.

#### Font-Awesome-Rails:

I added this just for a couple of icons in the tables.

#### jQuery-Rails:

This was only applied as it was required for the bootstrap library, nothing special here.

* * *

### Environment Variables

#### Figaro:

I was just checking this library out as it would be handy in future projects, I only used it to store an environment variable for the API Token instead of hard coding it into the project and posting it to GitHub.

* * *

### HTTP Requests

#### HTTPary:

I decided to use this library instead of the default library included with Ruby, the syntax is a lot cleaner and HTTP requests could be made in a single line.

* * *

### Admin Panel

#### Rails Admin

I used this library to help troubleshoot my database while setting it up. It helped quite a bit by allowing me to add, remove and test adding and removing objects from a web interface.
