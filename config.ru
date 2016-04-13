# This file is used by Rack-based servers to start the application.
require 'rack/reverse_proxy'

require ::File.expand_path('../config/environment', __FILE__)

run Rails.application
