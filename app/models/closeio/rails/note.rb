module Closeio
  module Rails
    class Note < Base
      def self.create!(payload)
        Closeio::Rails.configuration.client.create_note(payload)
      end
    end
  end
end