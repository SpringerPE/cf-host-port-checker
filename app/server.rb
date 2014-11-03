require 'sinatra'
require 'rack-flash'
enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

require_relative 'models/checker'
require_relative 'controllers/application'





