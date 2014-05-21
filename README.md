# Ruby on Rails  
  
Rails is simple, but the knowledge builds up quickly. We're going to
be going over some projects. In class, we'll be covering a project
called "Awesome Answers". Please try to follow along with this, as we
will be continuing from where we left off, on a daily basis.  
  
There will also be a project for a "Project Management Tool" that will
be applying the principles learned through exercises with "Awesome
Answers."  
  
**Rails**
  * saves you a lot of time
  * has a large community
  * has many gems
  * is a well known framework  
  
Rails was created by David Heinemeir Hansson
([DHH](https://twitter.com/dhh)) of [37
Signals](https://37signals.com/). Github uses rails, groupon,
shopify, yellow pages, Basecamp, twitter (at first).  
  
Rails is very opinionated. The core team made decisions to do
things a certain way, and so there are many conventions in rails.
Rails is a gem, just like Sinatra.  
  
Let's start by installing rails, if you haven't already.  
```bash
gem install rails
# or
gem install rails --no-rdoc
```  
If you specify a gem version with `~>`, it will install the latest
stable version, i.e. in the case of rails 4.0.4, it would install up
to 4.0.9, but not 4.1.  
```bash
gem 'rails', '~> 4.0.4'
```  
Rails comes with many parts, including actionmailer, so we no
longer need the Pony gem, for example.  
  
Create a new rails project called "awesome_answers", using a
postgresql database.  
```bash
rails new awesome_answers -d postgresql
```  
cd into the directory rails created called "awesome_answers" and open
it up in your favorite text editor.  
```bash
cd awesome_answers
subl .
```  
  
## Files and Structure
```bash
config.ru           # is where we tell the server to require our app.
.gitignore          # here we can list files we do not want git to
track, e.g. config/database.yml
config/database.yml # if you are using postgres, or any database
other than sqlite, you will need to specify your username
```  
  
**app**: This organizes your application components. It's got
subdirectories that hold the view (views and helpers), controller
(controllers), and the backend business logic (models).

**app/controllers**: The controllers subdirectory is where Rails
looks to find controller classes. A controller handles a web
request from the user.

**app/helpers**: The helpers subdirectory holds any helper classes used
to assist the model, view, and controller classes. This helps to keep
the model, view, and controller code small, focused, and uncluttered.

**app/models**: The models subdirectory holds the classes that
model and wrap the data stored in our application's database. In most
frameworks, this part of the application can grow pretty messy,
tedious, verbose, and error-prone. Rails makes it dead simple!

**app/view**: The views subdirectory holds the display templates to fill
in with data from our application, convert to HTML, and return to the
user's browser.

**app/view/layouts**: Holds the template files for layouts to be used
with views. This models the common header/footer method of wrapping
views. In your views, define a layout using the `layout :default` and
create a file named default.rhtml. Inside default.rhtml, call `<%
yield %>` to render the view using this layout.  
ref:
[tutorialspoint](http://www.tutorialspoint.com/ruby-on-rails/rails-directory-structure.htm)  
  
## database.yml
```ruby
# config/database.yml
development:
  adapter: postgresql
  encoding: unicode
  database: awesome_answers_development
  pool: 5
  username: my_mac_username             # in terminal type whoami if
you wish to see your Mac username.
  password:

test:
  adapter: postgresql
  encoding: unicode
  database: awesome_answers_test
  pool: 5
  username: my_mac_username           
  password:

# production:                           # because we will deploy to
Heroku, which sets its own database, we don't need this
#   adapter: postgresql
#   encoding: unicode
#   database: awesome_answers_production
#   pool: 5
#   username: my_mac_username
#   password:
```  
Make sure you are in your app's directory "awesome_answers" and run the
command `rails s` or `rails server` in the terminal. This should
start up your rails server, and give a message like this  
```bash
=> Booting WEBrick
=> Rails 4.0.2 application starting in development on
http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
[2014-03-24 10:09:23] INFO  WEBrick 1.3.1
[2014-03-24 10:09:23] INFO  ruby 2.1.0 (2013-12-25)
[x86_64-darwin12.0]
[2014-03-24 10:09:23] INFO  WEBrick::HTTPServer#start: pid=90355
port=3000
```  
If you get an error stating the databse does not exist, run `rake
db:create`.  
  
## MVC
MVC resources: [video](https://www.youtube.com/watch?v=3mQjtk2YDkM) |
[Coding
Horror](http://blog.codinghorror.com/understanding-model-view-controller/)
| [Better
Explained](http://betterexplained.com/articles/intermediate-rails-understanding-models-views-and-controllers/)  
In Sinatra, we had our routes in our controllers, when we did
something like  
```ruby
get "/" do
  @tasks = Task.all         # Task is a model
  erb :index                # index.erb is a view
end
```  
In Rails, we have a separate file for routes called `routes.rb`  

**Model**  
The model represents the information and the data from the
database. It is as independent from the database as possible (Rails
comes with its own O/R-Mapper, allowing you to change the database that
feeds the application but not the application itself). The model also
does the validation of the data before it gets into the database. Most
of the time you will find a table in the database and an according
model in your application.  
  
**View**  
The view is the presentation layer for your application. The view
layer is responsible for rendering your models into one or more
formats, such as XHTML, XML, or even Javascript. Rails supports
arbitrary text rendering and thus all text formats, but also
includes explicit support for Javascript and XML. Inside the view you
will find (most of the time) HTML with embedded Ruby code. In
Rails, views are implemented using ERb by default.  
  
**Controller**  
The controller connects the model with the view. In Rails,
controllers are implemented as ActionController classes. The
controller knows how to process the data that comes from the model and
how to pass it onto the view. The controller should not include any
database related actions (such as modifying data before it gets
saved inside the database). This should be handled in the proper
model.  
  
**Helper**  
When you have code that you use frequently in your views or that is too
big/messy to put inside of a view, you can define a method for it
inside of a helper. All methods defined in the helpers are
automatically usable in the views.  
  
ref: [Rails
Wiki](http://en.wikibooks.org/wiki/Ruby_on_Rails/Getting_Started/Model-View-Controller)  
  
## Convention over Configuration  
Rails goes with the motto "Convention over Configuration". So,
instead of having to spend a lot of time configuring options, we
follow a set of conventions.  
For example, in Sinatra, we might have something like  
```ruby
# app.rb
get "/" do
  @task = Task.all
  erb :index          # Here we have to state erb :index to render this
view
end  

# Rails 
def index             # In Rails, we just define a method for each view
in its controller
end
```  
  
## Gemfile & Bundler
Our Gemfile stores all the gems we use in our application.  
```ruby
# Gemfile

source 'https://rubygems.org'         # this is currently (and for the
foreseeable future) the main source for rubygems

gem 'rails', '4.0.2'                  # this uses the specfic rails
version '4.0.2'
gem 'pg'
gem 'sass-rails', '~> 4.0.0'          # this will use sass-rails up to
version 4.0.9
gem 'uglifier', '>= 1.3.0'            # this will use an uglifier
version greater than or equal to 1.3.0
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

```  
Add thin to your Gemfile  
```ruby
# Gemfile

source 'https://rubygems.org'         # this is currently (and for the
foreseeable future) the main source for rubygems

gem 'rails', '4.0.2'                  # this uses the specfic rails
version '4.0.2'
gem 'pg'
gem 'thin'                            # add thin instead of webrick

gem 'sass-rails', '~> 4.0.0'          # this will use sass-rails up to
version 4.0.9
gem 'uglifier', '>= 1.3.0'            # this will use an uglifier
version greater than or equal to 1.3.0
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do          # require gems for
development and test environments
  gem 'debugger'
  gem 'rspec-rails'
end

```  
Then run `bundle install` to update your app to use thin, and make sure
to restart your server  
```bash
ctrl-c
rails s
```  
## REST  
Routes in rails use [RESTful
architecture](http://en.wikipedia.org/wiki/Representational_state_transfer}
(Representational state transfer). Let's look at what this means.  
  
Inside your app's directory, in the terminal type `rails generate
controller home`. Then, open up your routes.rb file.  
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do

  get "/about_us" => "home#about"         # we add get, then give a
path, followed a hashrocket. We then reference
                                          # 'home' which is a
controller, and about (method in the home controller)
end

```  
get is an HTTP verb.
  * GET
  * POST
  * PATCH/PUT
  * DELETE  
  
Add a method to your home_controller called about.  

```ruby
# app/controllers/home_controller.rb
class HomeController < ApplicationController

  def about
    render text: "Welcome"
  end
  
end
```  
Here we are just rendering the text "Welcome". However, by default, the
method name in the controller will look for a view.erb file. So,
let's set one up. Create a page called about.erb in your
app/views/[controller] directory.  
```ruby
# app/views/home/about.erb

<h1>Hello!</h1>

```  
Now, remove the line `render text: "Welcome"` from your
home_controller.  
```ruby
# app/controllers/home_controller.rb
class HomeController < ApplicationController

  def about
  end
  
end
```  
Let's add an FAQ.  
```ruby
# config/routes.rb
get "/faq" => "home#faq"          # add this line to your routes file
```  
define a method in your home controller.  
```ruby
# app/controllers/home_controller.rb
class HomeController < ApplicationController

  def about
  end
  
  def faq
  end
  
end
```  
Create an faq.erb file in your views directory  
```ruby
# app/views/home/faq.erb
<h1>FAQ</h1>
```  
What's a controller?  
It's a class  
```ruby
app/controllers/home_controller.rb
class HomeController < ApplicationController              # our home
contoller inherits from ApplicationController.

  def about
  end
  
  def faq
  end

end
```  
application_controller.rb
```ruby
app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
```  
`protect_from_forgery` makes it so you can't easily put something or
post something, without an authorization token. Basically by having this
in the application_controller, all my controllers have this as long as
they *inherit from this controller*.  
  
```ruby
# config/environments/production.rb
AwesomeAnswers::Application.configure do

  config.cache_classes = true

  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your
application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching
reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will
already do this).
  config.serve_static_assets = false

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is
missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your
assets.
  config.assets.version = '1.0'

  # Force all access to the app over SSL, use
Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true  # Here we can force_ssl

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an
asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in
app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  # Ignore bad email addresses and do not raise email delivery
errors.
  # Set this to true and configure the email server for immediate
delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall
back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not
suppressed.
  config.log_formatter = ::Logger::Formatter.new
end
```  
If I want to create a special section in my website for help, what
should I do? Where should I start? (in terminal in the directory of your
application)
```bash
rails generate controller help  

#############################
#### To see the options available to generate, try just rails generate
#############################

rails generate

Rails:
  assets
  controller
  generator
  helper
  integration_test
  jbuilder
  mailer
  migration
  model
  resource
  scaffold
  scaffold_controller
  task

Coffee:
  coffee:assets

Jquery:
  jquery:install

Js:
  js:assets

TestUnit:
  test_unit:plugin

```   

Then add some routes to the routes.rb  
```ruby
# config/routes.rb
# ...
  get "/help" => "help#index"
  
#...
```  

Add an index method to the help controller
```ruby
class HelpController < ApplicationContoller
  
  def index
  end

end  
```  
  
Add an index.erb inside a help directory to the views diretory  
```ruby
app/views/help/index.erb
<h1>Welcome to the help section</h1>
```   
  
We can access all the routes available in our app if we go to
[localhost:3000/rails/info/routes](http://localhost:3000/rails/info/routes)  
  
We can see in our routes that rails automatically generates
'helpers' for us. Rather than /about_us, we now have a rails method we
can use to access this route through our app called `about_us_path`.  
  
We use this to create links, for example add a navigation section
```ruby
# app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
<head>
  <title>AwesomeAnswers</title>
  <%= stylesheet_link_tag    "application", media: "all",
"data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" =>
true %>
  <%= csrf_meta_tags %>
</head>
<body>

# Add a navigation section here

  <%= link_to "About Us", about_us_path, class: "btn btn-primary", id:
"about" %> | 
  <%= link_to "FAQ", faq_path %> | 
  <%= link_to "Help", help_path %>

<%= yield %>

</body>
</html>

```  
## Rails Resources  

If I have a resource called post, it will be a model Post.rb, and a
controller posts_controller.rb. Models are given singular names, and
controllers are given the plural of the model, by convention, and this
is how rails works.    
Let's start by creating a controller: `rails generate controller
questions`.  
  
To show all the questions, we can define a method called index in the
questions_controller.  
```ruby
class QuestionsController < ApplicationController

  def index
  end
  
end
```  
And add a route 
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do

  get "/" => "home#index"

  get "/about_us" => "home#about"

  get "/faq" => "home#faq"

  get "/help" => "help#index"

  get "/questions" => "questions#index"

end
```  
Add an index.html.erb page to the view  
```ruby
# app/views/qustion/index.html.erb
<h1>Listing All Questions</h1>


```  
If I want to create a question, I need to define a method create. What
should the route for this be? `post "/questions => "questions#index"` 
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do

  get "/" => "home#index"

  get "/about_us" => "home#about"

  get "/faq" => "home#faq"

  get "/help" => "help#index"

  get "/questions" => "questions#index"
  post "/questions" => "questions#index"

end
```  
If  want to show a specific question, what should I do? That's
right! `get "/questions/:id" => "questions#show"`  
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do

  get "/" => "home#index"

  get "/about_us" => "home#about"

  get "/faq" => "home#faq"

  get "/help" => "help#index"

  get "/questions" => "questions#index"
  post "/questions => "questions#index"
  get "/questions/:id" => "questions#show"

end
```   
And of course, then define the `show` method in the
questions_controller.  
```ruby
# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController

  def index
  end

  def create
  end
  
  def show
    render text: "The id is: #{params[:id]}"     #we can get the
question based on it's ID. This is available through params
  end

end
```  
To edit, update, and destroy a question, we can add the according
methods and routes.  
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do

  root "questions#index"        # specify the root path just like
                                # get "/" => "questions#index"

  get "/about_us" => "home#about"

  get "/faq" => "home#faq"

  get "/help" => "help#index"

  get "/questions"          => "questions#index"
  post "/questions"         => "questions#create"
  get "/questions/:id"      => "questions#show"
  get "/questions/:id/edit" => "questions#edit"
  match "/questions/:id"    => "questions#update", via: [:put,
:patch]
  delete "/questions/:id"   => "questions#destroy"
  
  
  ### Note, we can create all these routes by adding the simple line
  resources :questions
  
  ### to limit the routes available to questions, we can add only
  resources :questions, only: [:index, :new, :create]

end
```   

Methods
```ruby
# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController

  def index
  end

  def create
    render text: "Create a question"
  end

  def show
    render text: "The id is: #{params[:id]}"
  end

  def edit
    render text: "Editing question: #{params[:id]}"
  end

  def new
    render text: "A new question"
  end

end
```  
If I want to do something like vote on a question, I can add a path to
the routes.rb such as:  
```ruby
# config/routes.rb
  resources :questions do 
    post :vote_up, on: :member
  end
```  
  
This will create the route `vote_up_question_path POST
/questions/:id/vote_up(.:formattert) questions#vote_up`. We are
voting up on member, because we are selecting a particular member in a
collection. If want to search a collection of questions, I would add
`post :search, on: :collection` to the routes resource. A
collection doesn't require an id, whereas a member does.  
```ruby
# config/routes.rb
  resources :questions do 
    post :vote_up, on: :member
    post :search, on: :collection
  end
```   
This creates the route `search_questions_path POST
/questions/search(.:format) questions#search`.  If we want to have a
series of methodhods on a member or collection, he's the syncax.  
```ruby
# config/routes.rb
  resources :questions, only: [:index, :create, :show] do     # in
contrast to only, we could use except: [:update, :create], etc.
    member do 
      post :vote_up
      post :vote_down
    end
    post :search, on: :collection
  end
```
# Active Record  
  
**What is a model?**  
When I try to model my app into objects, I used these classes to
represent the different entities in my application. When we want to map
the database, we use an ORM. We used DataMapper in Sinatra. In
Rails, we use ActiveRecord.  
  
Our Question and Answer app is going to have two models: Question and
Answer.  
  
What kind of information do I need in the Question model?  
  * id
  * title
  * description   

And in the Answer model?  
  * id
  * body  

Let's start by creating the Question model. Active Record's
approach to things is a little different from DataMapper. The way to
generate a model is using `rails generate [model-name]`. For our
controllers, we used plural names, however for models we use
singular. The table will be plural. So, if we make a model called
'Task' the database table will be 'tasks'. Rails does this for us.  
  
We can add the attributes to our model in the command line, like so  
```ruby
rails generate model question title:string description:text
```  
***note***: I do not have to explicitly say, I need an id. One will be
created automatically.  
***noteII***: The opposite of 'generate' is destroy. So if I wanted to
destroy this model, I would use `rails destroy model question`   
  
Open up db/migrate/[migration-file]  
```ruby
class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
```  
  
Before running a `rake db:migrate` we could add different fields to the
migration file, and this will create them when it runs the
migration. For eample:  
```ruby
class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      # t.text :description, default: "no description"
      t.text :description
      t.integer :view_count             # add a view count field

      t.timestamps
    end
    add_index :questions, :title        # adding an index speeds up
queries
  end
end
```  
We can put validations in our app for what data is stored in the
database. Some teams may have server-side validation as well.  
  
Run `rake db:migrate` to migrate. This will also create a db/schema.rb
file which shows the table structure for the database. Some more
[Active Record
migration](http://guides.rubyonrails.org/migrations.html) commands
`rake db:create`, `rake db:migrate`, `rake db:rollback`, `rake
db:reset`, `rake db:migrate:reset`.  
  
```ruby
db:create           # creates the database for the current env
db:create:all       # creates the databases for all envs
db:drop             # drops the database for the current env
db:drop:all         # drops the databases for all envs
db:migrate          # runs migrations for the current env that have not
run yet
db:migrate:up       # runs one specific migration
db:migrate:down     # rolls back one specific migration
db:migrate:status   # shows current migration status
db:migrate:rollback # rolls back the last migration
db:forward          # advances the current schema version to the next
one
db:seed             # (only) runs the db/seed.rb file
db:schema:load      # loads the schema into the current env's database
db:schema:dump      # dumps the current env's schema (and seems to
create the db as well)

db:setup            # runs db:schema:load, db:seed

db:reset            # runs db:drop db:setup
db:migrate:redo     # runs (db:migrate:down db:migrate:up) or
(db:migrate:rollback db:migrate:migrate) depending on the specified
migration
db:migrate:reset    # runs db:drop db:create db:migrate
```  
  
To add a migration that adds something to a table, you can do
something like  
```ruby
rails generate migration add_like_count_to_questions
```  
Open up your migration file, and add a column  
```ruby
class AddLikeCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :like_count, :integer
  end
end
```  
Add a migration to remove like_count from question `rails generate
migration remove_like_count_from_questions`  
Open up the migration and add a line to remove the column  
```ruby
class RemoveLikeCountFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :like_count, :integer
  end
end
```  
***Note***: If you just made a mistake, you can rollback, make the fix,
and delete that migration. However, if you are working on an app that
is in production, or working with a team, you always want to fix
forward, ie: migrate to add or remove columns, etc.  
  
## Rails Console  
To start the rails console, you can do `rails c` or `rails
console`. This is similar to irb, but you use it while in your
app's directory, and it has access to your rails app.  
  
Let's hope into rails console, and create a new question.  
```bash
rails c  
q = Question.new
=> #<Question id: nil, title: nil, description: nil, created_at: nil,
updated_at: nil>

# add title, and description
q.title = "My first question title from console."
q.description = "Here is a fine description of this question that I am
apparently not asking."
q
 => #<Question id: nil, title: "My first question title from
console.", description: "Here is a fine description of this
question that I ...", created_at: nil, updated_at: nil>
```  
To see if an object has gone into the database yet or not, you can use
the `persisted?` method. try `q.persisted?`. To save into the
databse, run `q.save`. Then check what the output of `q` is.  
```bash
q.save
q
 => #<Question id: 1, title: "My first question title from console.",
description: "Here is a fine description of this question that I ...",
created_at: "2014-03-25 17:16:46", updated_at: "2014-03-25 17:16:46">
 ```  
 
 Now, if we add some information to it, and save it again, our
`created_at` and `updated_at` will be different.  
 ```bash
 q.description = "What is the output of the question now?"
 q.save
 q
  => #<Question id: 1, title: "My first question title from console.",
description: "What is the output of the question now?", created_at:
"2014-03-25 17:16:46", updated_at: "2014-03-25 17:18:39">
```  
We can also pass in a has of parameters when called Question.new  
```bash
q2 = Question.new(title: "Another question for you", description: "Do
I have butterflies in my stomach all the time, because I'm super
excited about everything, or because the world is constantly falling?")
q2.save
q2
 => #<Question id: 2, title: "Another question for you",
description: "Do I have butterflies in my stomach all the time, b...",
created_at: "2014-03-25 17:20:27", updated_at: "2014-03-25 17:20:27">
 ```   
To create without doing `.new` and `.save`, we can use `.create`  

```bash
Question.create(title: "I have a question.", description: "How many
times have you given an egg to a raccoon?")
```  
## Add data validation  
Open up the question model and add `validates_presence_of :title`  
```ruby
# app/models/question.rb
class Question < ActiveRecord::Base

  validates_presence_of :title
  
end
```  
Then try saving a question in rails c without a title.  
```rake
# in rails console
reload!
q = Question.new
q.save
   (0.3ms)  BEGIN
[deprecated] I18n.enforce_available_locales will default to true in the
future. If you really want to skip validation of your locale you can
set I18n.enforce_available_locales = false to avoid this message.
   (0.4ms)  ROLLBACK
 => false 


# then check the errors!
q.errors
 => #<ActiveModel::Errors:0x000001022ebbb8 @base=#<Question id: nil,
title: nil, description: nil, created_at: nil, updated_at: nil>,
@messages={:title=>["can't be blank"]}> 
```  
[Validation
reference](http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html)  
  
Now add validation for the title to be unique using an alternative
syntax that allows for more attributes.  
```ruby
# app/models/question.rb
class Question < ActiveRecord::Base
 
  # validates_presence_of :title
  validates :title, presence: true, uniqueness: true
  
  validates_presence_of :description, message: "must be present"
  
end
```   
To update the attributes of a record in the database, use
`update_attributes`  
```bash
q.update_attributes(title: "updated title", description: "some new
description")
```  
Some other class methods  
```bash
Question.first
Question.last
Question.all
# Question.destroy_all        # will delete all records
Question.find_by_title "abc"
```  
To have your data records display nicely in the rails console, you can
use the gem hirb. Since you only need it for development, add it to a
group in your Gemfile  
```ruby
# Gemfile
#...

group :development do
  gem 'hirb'
  gem 'interactive_editor'
  gem 'awesome_print'
end

#...
```  
After adding to your Gemfile, do a `bundle install` in the
terminal, then in `rails c` do `Hirb.enable`. Add the following to your
.irbrc dotfile. This will require and enable 'hirb' when irb (or rails
c) loads, and if not, it will give an error.  
```ruby
# ~/.irbrc 

#...

begin
  require 'hirb'
  Hirb.enable
rescue LoadError => err
  warn "Couldn't load hirb: #{err}"
end

#...

```  
Try some more class methods  
```bash
Question.select(:id, :title, :description)
Question.select(:id, :title, :description).limit(2)
Question.select(:id, :title, :description).offset(2)
```  
## Basic Queries  
Queries are, in a large part, based on the `WHERE` statment.  
Here are some examples  
```bash
Question.where.not(title: "abc")                # will return all
questions where the title is not equal to "abc"
Question.where(["title like ?", "%fas%"])       # I pass in an array
to the WHERE. The first argument is the query string.
Question.where(["description like ?", "%fas%"])

# to find all records where title or description contains a string
Question.where(["title like ? OR description like ?", "%fas%",
"%fas%"])

Question.where(["title like ? OR description like ?", "%title%",
"%what%"]).where(["created_at > ?", 10.days.ago])

Question.order("title ASC")
Question.order("title DESC")
```   
Adding limits to the model, using
[scopes](http://api.rubyonrails.org/classes/ActiveRecord/Scoping/Named/ClassMethods.html#method-i-scope)  
```ruby
# app/models/question.rb
class Question < ActiveRecord::Base

  #validates_presence_of :title
  validates :title, presence: {message: "must be there"}  ,
uniqueness: true

  validates_presence_of :description, message: "must be present"
  
  # a default scope will be used for al queries
  default_scope order("title ASC")

  # "->" is shorthand for lambda
  # to pass in a variable, use "->(x)"
  # scope :recent_tn, lambda { order("created_at DESC").limit(10) }
  
  scope :recent, lambda {|x| order("created_at DESC").limit(x) }
  scope :recent_ten, -> { order("created_at DESC").limit(10) }
  
  # this can be shorted by writing a scope
  def self.recent_ten
    order("created_at DESC").limit(10)
  end
  
  def self.recent(x)
    order("created_at DESC").limit(x)
  end
  
end
```  
## Callbacks  
Callbacks are widely used in Active Record (see: [Active Record
Callbacks](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)).
Sometimes I want to do an operation on something before I add it to a
record, and I want to do it to every record in the databse. Let's say I
want to capitalize the title before i save it in the database, I can
do something like this:  
```ruby
# app/models/question.rb
class Question < ActiveRecord::Base

  #validates_presence_of :title
  validates :title, presence: {message: "must be there"}  ,
uniqueness: true

  validates_presence_of :description, message: "must be present"
  
  # a default scope will be used for al queries
  default_scope order("title ASC")

  # "->" is shorthand for lambda
  # to pass in a variable, use "->(x)"
  # scope :recent_tn, lambda { order("created_at DESC").limit(10) }
  
  scope :recent, lambda {|x| order("created_at DESC").limit(x) }
  scope :recent_ten, -> { order("created_at DESC").limit(10) }
  
  # this can be shorted by writing a scope
  def self.recent_ten
    order("created_at DESC").limit(10)
  end
  
  def self.recent(x)
    order("created_at DESC").limit(x)
  end
  
  before_save :capitalize_title             # call the before_save
action :capitalize_title
  
  private
  
  def capitalize_title                 # create a method to
capitalize the title before saving
    self.title.capitalize!
  end
  
end
```  
# Building a Rails CRUD  
  
For the questions index page create an instance variable with all
questions.  

```ruby
# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def create
    render text: "Create a question"
  end

  def show
  end

  def edit
    render text: "Editing question: #{params[:id]}"
  end

  def new
    render text: "A new question" 
  end

  def destroy
    render text: "Question: #{params[:id]} has been successfully
deleted."
  end

end
```  
  
On the index.html.erb set some items to display each question,
including title, description, and created_at using Ruby's
[strftime](http://www.ruby-doc.org/core-2.1.1/Time.html#method-i-strftime)
method.  
```erb
# app/views/questions/index.html.erb
<h1>Listing All Questions</h1>

<% @questions.each do |question| %>
  
    <h2><%= question.title %></h2>
    <p><%= question.description %></p>
    <p>Created On: <%= question.created_at.strftime("%Y-%b-%d")
%></p>
    <hr>
    
<% end %>

```  
Let's create a page where we can fill in a question title and
description, and we can click a button to save it in the database. The
first step is inside the new method of our questions_controller.rb,
we will instantiate a question instance variable.  
```ruby
# app/controllers/questions_controller.rb  

# ...
def new
  @question = Question.new
end

# ...

```  
Now we need a view called 'new' to enter the information for our new
question.  
```erb
# app/views/questions/new.html.erb  
<h1>New Question</h1>

<% form_for @question do |f| %>

  <%= f.label :title %>
  <%= f.text_field :title %>
  
  <%= f.lable :description %>
  <%= f.text_area :description %>
  
  <%= f.submit %>
  
<% end %>

```  
Params is a hash of hashes, some of its keys have hashes inside,
auth.token, question {title: "...", description: "..."}. We can see
these parameters when we submit a new question.  
```bash
Started POST "/questions" for 127.0.0.1 at 2014-03-26 13:47:37 -0700
Processing by QuestionsController#create as HTML
  Parameters: {"utf8"=>"✓",
"authenticity_token"=>"w0WxTUZNQrbHnIHsuwfTYtJxKtYGzN3XlnOb88xc7qw=",
"question"=>{"title"=>"Here's a question",
"description"=>"kljsdlkajs ajsfd kljf;k djsaf"}, "commit"=>"Create
Question"}
```  
In your questions controller add a method create that will render text
showing the question title.    
```ruby
# app/controllers/questions_controller.rb  

# ...

def create
  render text: "Create..#{params[:question][:title]}"
end

# ...  
Now, to save this to the database, we will need to modify the
create method. We no longer have access to the instance variable from
the new request, so we need a new instance of question.  

```ruby
# app/controllers/questions_controller.rb  

# ...

def create
  @question = Question.new
  @question.title = params[:question][:title]
  @question.title = params[:question][:description]
  @question.save
  redirect_to questions_path
end

```  
Our logs have a lot of entries for accessing html/css files. We don't
really care about those, so to remove them, you can just add `gem
quiet_assets` to your Gemfile.  
  
Let's refactor that create method to be a little better.  
```ruby
# app/controllers/questions_controller.rb  

# ...

def create
  #@question = Question.new(params[:question]) # We used to be able
to do this, but there were some security issues.
  # now, in Rails 4, the default action is to prevent everything,
rather than allowing. 
  question_attributes = params.require(:question).permit([:title,
:description])
  @question = Question.new(question_attributes)
  
  if @question.save
    redirect_to questions_path, notice: "Your question was created
successfully."
  else
  flash.now[:error] = "PLease correct the form"
    render :new
  end
end

```  
In IRB, try saving an instance variable question without the
required params, then check the errors.  
```bash
q = Question.new
q.save
q.errors.any?
q.errors
q.errors.messages
```   
Let's add a way to display errors on our new question form:  
```erb
# app/views/questions/new.html.erb  
<% if @question.errors.any? %>

 <ul>
   <% @question.errors.full_messages.each do |message| %>
     <li><%= message %></li>
   <% end %>
  </ul>
<% end %>

<% form_for @question do |f| %>

  <%= f.label :title %>
  <%= f.text_field :title %>
  
  <%= f.lable :description %>
  <%= f.text_area :description %>
  
  <%= f.submit %>
  
<% end %>

```  
Set the flash notices to display through the application layout.  

```erb
#app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
<head>
  <title>AwesomeAnswers</title>
  <%= stylesheet_link_tag    "application", media: "all",
"data-turbolinks-track" => true %>
  <%= javascript_include_tag "application",
"data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
<body>
  <div class="container">
    
    <nav class="nav-main">
      <%= link_to "About Us", about_us_path, class: "btn
btn-default nav-btn", id: "about" %>
      <%= link_to "FAQ", faq_path, class: "btn btn-default nav-btn" %>
      <%= link_to "Help", help_path, class: "btn btn-default nav-btn"
%>
      <%= link_to "New Question", new_question_path, class: "btn
btn-default nav-btn" %>
    </nav>
      
    <% if flash[:notice] || flash[:error] %>
      <h3><%= flash[:notice] || flash[:error] %></h3>
    <% end %>

    <%= yield %>
  
    
  
  </div>
</body>
</html>
```  
We can add private methods to our questions_controller.rb to clean this
up a little, and define the method for  questions_attributes
outisde the create method.  
```ruby
# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def create
    #@question = Question.new(params[:question]) # We used to be able
to do this, but there were some security issues.
    # now, in Rails 4, the default action is to prevent
everything, rather than allowing. 
    @question = Question.new(question_attributes)

    if @question.save
      redirect_to questions_path, notice: "Your question was
created successfully."
    else
      flash.now[:error] = "Please correct the form"
      render :new
    end
  end

  def show
  end

  def edit
    render text: "Editing question: #{params[:id]}"
  end

  def new
    @question = Question.new 
  end

  def destroy
    render text: "Question: #{params[:id]} has been successfully
deleted."
  end
  
  private
  
  def question_attributes
    question_attributes =
params.require(:question).permit([:title, :description])
  end
end
```
How do I add a link to my homepage in order to take me to a form where
I can create my new question?
  
```erb
# app/views/questions/index
 <h1>Listing All Questions</h1>
 
 <%= link_to "Create New Question", new_question_path %>
 
  <% @questions.each do |question| %>
 
  <h2><%= link_to question.title, question_path(question) %></h2>
 
  <p><%= question.description %></p>
 
  <p>Created On: <%= question.created_at.strftime("%Y-%b-%d") %></p>
 
  <hr>
 
 <% end %> 
```  
If I want to show the actual question, I should change my
questions controller. What should I do? And let's create a way to click
on a specific question, where I can view the details of that
question. And link back to the questions index page.  And even edit
or delete that question.  
```ruby
#app/controllers/questions_controller.rb

# ...

def show
  @question = Question.find(params[:id])
end

# ...
```

```erb
#app/views/questions/show.html.erb

<h1><%= @question.title %></h1>
<p><%= @question.description %>
<p><%= @question.created_at.strftime("%Y-%b-%d") %>

<br>

<%= link_to "Edit", edit_question_path(@question) %>

<br>

<%= link_to "All Questions", questions_path %>

```  
Add a method in your questions_controller to edit.  
```ruby
# app/controllers/questions_controller.rb

#...

def edit
  @question = Question.find(params[:id])
end

#...


```
Edit Page  
```erb
# app/views/questions/edit.html/erb
<h1>Editing Question</h1>

<%= form_for @question do |f| %>
  
  <div class="form-field">
    <%= f.label :title, "TitLe" %>
    <%= f.text_field :title, class: "form-control" %>
  </div>

  <div class="form-field">
    <%= f.label :description %>
    <%= f.text_area :description, class: "form-control" %>
  </div>

  <%= f.submit %>

<% end %>
```  
Rather than repeat the same thing to instantiate a question in each
of your methods. It's a good idea to perform something called a
'before action' which will instantiate a question object for you.  

```ruby
class QuestionsController < ApplicationController
  before_action :find_question, 
                  only: [:show, :edit, :destroy, :update]

  def index
    @questions = Question.all
  end

  def create
    #@question = Question.new(params[:question]) # We used to be able
to do this, but there were some security issues.
    # now, in Rails 4, the default action is to prevent
everything, rather than allowing. 
    question_attributes =
params.require(:question).permit([:title, :description])
    @question = Question.new(question_attributes)

    if @question.save
      redirect_to questions_path, notice: "Your question was
created successfully."
    else
      flash.now[:error] = "Please correct the form"
      render :new
    end
  end
  
  def new
    @question = Question.new
  end

  def show
  end

  def edit
  end
  
  def update
  end

  def destroy
    render text: "Question: #{params[:id]} has been successfully
deleted."
  end
  
  private
  
  def find_question
    @question = Question.find(params[:id])
  end

end
```  
Also, rather than copy/pasting our form to mulitple pages, we can
create what's called a partial (note partial filenames begin with an
underscore "_").  
```erb
# app/views/questions/_form.html.erb
<%= form_for @question do |f| %>
  
  <div class="form-field">
    <%= f.label :title, "TitLe" %>
    <%= f.text_field :title, class: "form-control" %>
  </div>

  <div class="form-field">
    <%= f.label :description %>
    <%= f.text_area :description, class: "form-control" %>
  </div>

  <%= f.submit %>

<% end %>

```  
Then, we can call this form partial in a view file with 'render'  
```erb
# app/views/questions/new.html.erb

<h1>Create New Question</h1>

<%= render 'form' %>
```   
```erb
# app/views/questions/edit.html.erb

<h1>Edit Question</h1>

<%= render 'form' %>
```  
If you want to use a partial from another folder, you will need to use
the full path starting from views. For example,
views/questions/_form.html.erb.  
  
How can we get a different label on the button, based on wether the
question is in the database or not?   

`<%= f.submit (@question.persisted? ? "Update" : "Save"), class: "btn
btn-default" %>`  
  
To update a question in our databse through a form, we will create a
private method question_attributes  
```ruby
# app/controllers/questions_controller.rb

# ...
def update
  if @question.update_attributes(question_attributes)
    redirect_to @question, notice: "Question updated successfully"
  else
    flash.now[:error] = "Couldn't update!"
    render :edit
  end
end

private

def question_attributes
  params.require(:question).permit([:title, :description])
end

# ...
```  
Let's look now at the destroy action. What do I do to destroy a
record in the database?  
```ruby
# app/controllers/questions_controller.rb

#... 

def destroy
  if @question.destroy
    redirect_to questions_path, notice: "Question deleted
successfully."
  else
    redirect_to question_path, error: "We had trouble deleting."
  end
end
# ...  
```  
Then add a link to delete on the show page.  
```erb
# app/views/questions/show.html.erb
<h1><%= @question.title %></h1>
<p><%= @question.description %>
<p><%= @question.created_at.strftime("%Y-%b-%d") %>

<br>
<%= link_to "Edit", edit_question_path(@question) %>

<%= link_to "Delete", @question, method: :delete, data: { confirm: "Are
you sure you want to delete this question?" } %>
<br>

<%= link_to "All Questions", questions_path %>


```  
## Adding Votes  
You can specify the field in the migration, like so: `rails g
migration add_vote_count_to_questions vote_count:integer`  
This creates the field for us in our migration file  
```ruby
# db/migrate/201403279827982374_add_vote_count_to_questions.rb
class AddVoteCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :vote_count, :integer
  end
end
```  
If you want to give it a default of 0, you can do so manually.  
```ruby
# db/migrate/201403279827982374_add_vote_count_to_questions.rb
class AddVoteCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :vote_count, :integer, default: 0
  end
end
```  
Run `rake db:migrate` Then add a vote up link to your show page  
```erb
#app/views/questions/show.html.erb

<h1><%= @question.title %></h1>
<p><%= @question.description %>
<p><%= @question.created_at.strftime("%Y-%b-%d") %>

<br>
  <%= link_to "Vote Up", vote_up_question_path(@question) %>

<br>
<%= link_to "Edit", edit_question_path(@question) %>

<%= button_to "Delete", @question, method: :delete, data: {
confirm: "Are you sure you want to delete this question?" },
class: "btn btn-default" %>
<br>

<%= link_to "All Questions", questions_path %>
```  

Add some methods in your questions controller to vote up and vote down  
```ruby
# app/controllers/questions_controller.rb

class QuestionsController < ApplicationController
  before_action :find_question, 
                  only: [:show, :edit, :destroy, :update,
:vote_up, :vote_down]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    #@question = Question.new(params[:question]) # We used to be able
to do this, but there were some security issues.
    # now, in Rails 4, the default action is to prevent
everything, rather than allowing. 
    question_attributes =
params.require(:question).permit([:title, :description])
    @question = Question.new(question_attributes)

    if @question.save
      redirect_to questions_path, notice: "Your question was
created successfully."
    else
      flash.now[:error] = "Please correct the form"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @question.update_attributes(question_attributes)
      redirect_to @question, notice: "Question updated successfully"
    else
      flash.now[:error] = "Couldn't update!"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path, notice: "Question deleted
successfully."
    else
      redirect_to question_path, error: "We had trouble deleting."
    end
  end
  
  def vote_up
    @question.increment!(:vote_count)
    session[:has_voted] = true
    redirect_to @question
  end
  
  def vote_down
  end
  
  def search
  end

  private

  def question_attributes
    params.require(:question).permit([:title, :description])
  end

  def find_question
    @question = Question.find(params[:id])
  end

end

```

Then inside the show, add a vote count  
```ruby
```  
In our routes.rb the default for vote up on our show path is get. We
could make it a button, or if we want to keep it a link, we could add
`method: :post`.  
```erb
# app/views/questions/show.html.erb
<h1><%= @question.title %></h1>
<p><%= @question.description %>
<p><%= @question.created_at.strftime("%Y-%b-%d") %>

<p>Vote Count: <%= @question.vote_count %>
<br>
  <% if session[:has_voted] %>
    You voted already!
    <% else %>
  <%= button_to "Vote Up", vote_up_question_path(@question) %>
  <% end %>

<br>
<%= link_to "Edit", edit_question_path(@question) %>

<%= button_to "Delete", @question, method: :delete, data: {
confirm: "Are you sure you want to delete this question?" },
class: "btn btn-default" %>
<br>

<%= link_to "All Questions", questions_path %>
```  
## Adding Helper Methods  
We can use helper modules. When we use `rails generate
controller`, it automatically puts a helper for every controller in
the app/helpers directory.  
```ruby
# app/helpers/application_helper.rb
module ApplicationHelper
  def formatted_date(date)
date.strftime("%Y-%dateB-%d")
end
end
```  
Then in the index view  
```erb
<h1>Listing All Questionsuestions</h1>

<%= link_to "Create a New Question", new_question_path %>

<% @questions.each do |question| %>

    <h2><%= link_to question.title, question_path(question) %></h2>
    <p><%= question.description %></p>
    <p><p>Created On: <%= formatted_date(@question.created_at) %></p>
    <hr>

<% end %>
```  
and in the show page
```erb
<h1><%= @question.title %></h1>
<p><%= @question.description %>
<p><%= formatted_date(@question.created_at) %>

<br>
<% if session[:sessionhas_voted] %>
  You voted already! 
  <% else %>
  <%= button_to "Votese Up", vote_up_question_path(@question) %>
    <% end %>

<br>
<%= link_to "Edit", edit_question_path(@question) %>

<%= button_to "Delete", @question, method: :delete, data: {
confirm: "Are you sure you want to delete this question?" },
class: "btn btn-default" %>
<br>

<%= link_to "All Questions", questions_path %>

```

### Available Callbacks  (ActiveRecord::Callbacks::CALLBACKS)
```bash
:after_initialize
:after_find
:after_touch
:before_validation
:after_validation
:before_save
:around_save
:after_save
:before_create
:around_create
:after_create
:before_update
:around_update
:after_update
:before_destroy
:around_destroy
:after_destroy
:after_commit
:after_rollback
```  
**Bonus**: Rather than setting the default values for vote_count to 0
in the migration file, we could add an `after_initialize` action to
the model.  

```ruby
# app/models/question.rb
#...

after_intitialize :set_defaults

private

def set_defaults
  self.vote_count ||= 0
end
```  
