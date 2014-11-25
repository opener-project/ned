require 'opener/webservice'

module Opener
  class Ned
    class Server < Webservice::Server
      set :views, File.expand_path('../views', __FILE__)

      self.text_processor  = Ned
      self.accepted_params = [:input, :host, :port]
    end # Server
  end # Ned
end # Opener
