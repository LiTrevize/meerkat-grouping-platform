# README

## Setup
Ruby version: 2.7.4

Rails version: 5.2.6

Install sqlite3:
```
sudo apt install sqlite3
```

Install JavaScript Runtime (e.g. Node.js)
```
sudo apt install nodejs
```

Install all gems:
```
bundle install --without production
```

Migrate database:
```
bundle exec rake db:migrate
```

Set local ENV variable (e.g. google auth) in `./config/application.yml`

## Run Tests
Run cucumber
```
bundle exec rake cucumber
```

Run rspec
```
bundle exec rspec
```

## Run Server
Run server:
```
bundle exec rails server
```
