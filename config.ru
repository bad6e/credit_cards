# This file is used by Rack-based servers to start the application.
require 'rack/reverse_proxy'

require ::File.expand_path('../config/environment', __FILE__)

use Rack::ReverseProxy do
  reverse_proxy /^\/blog(\/.*)$/, 'http://toomanymiles.flywheelsites.com$1', :username => 'flywheel', :password => 'exotic-taste', :timeout => 500, :preserve_host => true
end

run Rails.application
