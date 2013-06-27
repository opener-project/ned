require 'sinatra/base'
require 'opener/webservice'
require 'httpclient'

module Opener
  class Ned
    class Server < Webservice
      set :views, File.expand_path('../views', __FILE__)
      text_processor Ned
      accepted_params :input, :host, :port
    end # Server
  end # Ned
end # Opener
