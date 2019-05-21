module Closeio
  module Rails
    class Webhook < Base
      def self.all
        Closeio::Rails.configuration.client.list_webhooks['data'].collect do |webhook|
          self.new(webhook)
        end
      end

      def self.create(params)
        response = Closeio::Rails.configuration.client.create_webhook(params)
        if response.has_key?('field-errors')
          raise Closeio::Error, "#{response['field-errors']['name']}"
        elsif response.has_key?('error')
          raise Closeio::Error, "#{response['error']}"
        else
          response
        end
      end

      def self.destroy!(id)
        response = Closeio::Rails.configuration.client.delete_webhook(id)
        if response.has_key?('field-errors')
          raise Closeio::Error, "#{response['field-errors']['name']}"
        elsif response.has_key?('error')
          raise Closeio::Error, "#{response['error']}"
        else
          response
        end

      end
    end
  end
end