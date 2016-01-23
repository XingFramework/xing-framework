server 'example.com', user: 'root', roles: %w{web app}
set :branch, "production"
set :application, "example.com"

set :rails_warmup_url, 'http://example.com'

# set :use_sudo, true # <- depends on deployment
