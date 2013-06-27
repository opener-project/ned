require 'sinatra/base'
require 'opener/webservice'
require 'httpclient'

module Opener
  class NED
    class Server < Webservice
      set :views, File.expand_path('../views', __FILE__)
      text_processor NED
      accepted_params :input, :host, :port
    end # Server
  end # NED
end # Opener
