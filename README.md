# Stock Manager Project

---
Here is a demo of the project:
## [Demo](http://35.236.72.81/)

---

### Requirements:
- Docker
- Docker-Compose

### How to get it up and running:
The following commands should be run from the root project directory.

#### Adding API Token Enviroment Variable
API token needs to be added from https://worldtradingdata.com.

```bash
$ echo 'STOCK_API_TOKEN: "WORD_TRADING_DATA_API_TOKEN"' >> stock-manager/config/application.yml
```
#### Building Docker Containers
Once Docker and Docker-Compose are installed, run the following commands to get it up and running.

``` bash
$ docker-compose build
$ docker-compose run rails rake db:create db:migrate db:seed
$ docker-compose up
```

You should now be able to access the site from your IP address, or simply by following your local host address

http://127.0.0.1:3000
