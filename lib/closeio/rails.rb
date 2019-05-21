require 'closeio'
require 'require_all'
require_rel '.'

module Closeio
  module Rails

    class << self
      attr_accessor :configuration
      def configure
        self.configuration ||= Configuration.new
        yield(configuration)
        self.configuration.configure_connection
      end
    end

    class Configuration
      attr_accessor :api_key, :verbose
      attr_reader :client

      def configure_connection
        @verbose ||= false
        @client = Closeio::Client.new(@api_key, @verbose, nil, true)
      end
    end

    class Error < StandardError

    end
  end
end
