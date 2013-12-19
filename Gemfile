source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=railstutorial_rails_4_0

gem 'rails', '~>4.0.0'

gem 'jquery-rails', '~>3.0.4'
gem 'turbolinks', '>=1.1.1' #for faster and more responsive page post-backing
gem 'jbuilder', '~>1.0.2'
gem 'haml-rails'

gem 'sass-rails', '~> 4.0.1'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 2.1.1'
gem 'bcrypt-ruby', '> 3.1.0'

#gem "therubyracer"
#gem "less-rails"
gem 'twitter-bootstrap-rails'


group :development do
  gem 'taps' #transfer data to and from databases in an agnostic fashion
  gem 'sqlite3', '1.3.8'
end


#required for heroku deployment
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc', '0.3.20', require: false
end
