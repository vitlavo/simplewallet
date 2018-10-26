# Simple wallet

## Current stack ###
* Ruby 2.5.1
* Rails 5.2.1
* PostgreSQL 9.5


## Install

### 1. Check out the repository

```shell
git clone git@github.com:vitlavo/simplewallet.git
```

### 2. Create database.yml file

Copy the sample database.yml file and edit the database configuration as required.

```shell
cp config/database.example.yml config/database.yml
```

### 3. Setup the database

Run the following commands to setup the database.

```shell
rails db:setup
```

### 4. Install gems

```shell
bundle install
```

### 5. Start the Rails server

You can start the rails server using the command given below.

```shell
rails s
```
