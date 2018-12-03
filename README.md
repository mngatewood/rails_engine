# Rails Engine

## Installation

1.  **Clone** this repo into your project directory.

SSH:
```
git clone git@github.com:mngatewood/rails_engine.git
```

HTTPS:
```
git clone https://github.com/mngatewood/rails_engine.git
```

2.  **Bundle** required dependencies

```
bundle install && bundle update
```

3.  **Build** the database

```
rake db:{drop,create,migrate,seed}
```

4.  **Run** the web server

```
rails -s
```

5. **Navigate** to the endpoints

http://localhost:3000/api/v1/customers 

http://localhost:3000/api/v1/merchants 

http://localhost:3000/api/v1/invoices 

http://localhost:3000/api/v1/items 

http://localhost:3000/api/v1/invoice_items 

http://localhost:3000/api/v1/transactions 

*These are examples of endpoints.  Additional routes can be found by running:*
```
rake routes
```

6.  **Test** the application
```
rspec
```


## Known-Working Configuration

* MacOS High Sierra v10.13.6

* Ruby 2.4.1

* Rails 5.1.6.1
