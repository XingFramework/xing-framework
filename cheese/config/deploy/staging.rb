server 'example.com', user: 'root', roles: %w{web app}
set :branch, "staging"
set :application, "staging.example.com"
set :rails_warmup_url, 'http://staging.example.com'

#set :use_sudo, true #<- depends on deploy
