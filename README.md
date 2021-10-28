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
bundle install
```

Migrate database:
```
bundle exec bin/rake db:migrate
```

Set local ENV variable (e.g. google auth) in `./config/application.yml`

Run server:
```
bundle exec bin/rails server
```
