module Closeio
  module Rails
    class CustomField < Base

      def self.all
        Closeio::Rails.configuration.client.list_custom_fields.collect do |field|
          self.new(field)
        end
      end

      def self.find(id)
        self.new(Closeio::Rails.configuration.client.find_custom_field(id))
      end

      def self.create(params)
        response = Closeio::Rails.configuration.client.create_custom_field(params)
        if response.has_key?('field-errors')
          raise Closeio::Error, "#{response['field-errors']['name']}"
        elsif response.has_key?('error')
          raise Closeio::Error, "#{response['error']}"
        else
          response
        end
      end

      def add_choice(choice)
        new_choices = choices.push(choice)
        Closeio::Rails.configuration.client.update_custom_field(id,choices: new_choices)
      end

      def remove_choice(choice)
        new_choices = choices.reject {|c| c == choice}
        Closeio::Rails.configuration.client.update_custom_field(id,choices: new_choices)
      end

      def set_all_choices(choices)
        Closeio::Rails.configuration.client.update_custom_field(id,choices: choices)
      end


    end
  end
end