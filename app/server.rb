require 'sinatra'
require 'sinatra/partial'

set :partial_template_engine, :erb

require_relative 'models/checker'
require_relative 'controllers/application'
require_relative 'helpers/application'





