module Closeio
  module Rails
    class Lead < Base
      attr_reader :contacts

      def self.all
        Closeio::Rails.configuration.client.list_leads("*", per_page: 99999).data.collect do |lead|
          self.new(lead.to_hash)
        end
      end

      def self.with_status(status)
        Closeio::Rails.configuration.client.list_leads("lead_status: #{status}", per_page: 99999).data.collect do |lead|
          self.new(lead.to_hash)
        end
      end

      def self.find(id)
        self.new(Closeio::Rails.configuration.client.find_lead(id))
      end

      def self.create!(payload)
        Closeio::Rails.configuration.client.create_lead(payload)
      end

      def contacts
        @contacts ||= super.collect do |contact|
          Contact.new(contact)
        end
      end


    end
  end
end