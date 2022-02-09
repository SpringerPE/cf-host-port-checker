require 'sinatra'
require 'sinatra/partial'
require 'httparty'

set :partial_template_engine, :erb
set :bind, '0.0.0.0'

require_relative 'models/checker'
require_relative 'controllers/application'
require_relative 'helpers/application'





