require 'sinatra'
require 'rack-flash'
require 'sinatra/partial'
enable :sessions
set :session_secret, 'super secret'
use Rack::Flash
set :partial_template_engine, :erb

require_relative 'models/checker'
require_relative 'controllers/application'
require_relative 'helpers/application'





