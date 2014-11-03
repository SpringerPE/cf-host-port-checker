require './app/server'
use Rack::Static, :urls => ['/css'], :root => 'public'


run Sinatra::Application
