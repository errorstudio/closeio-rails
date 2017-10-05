module Closeio
  module Rails
    module DateCoercion
      extend ActiveSupport::Concern
      included do
        def initialize(hash)
          hash['date_created'] = DateTime.parse(hash['date_created'])
          hash['date_updated'] = DateTime.parse(hash['date_updated'])
          hash['created_at'] = hash['date_created']
          hash['updated_at'] = hash['date_updated']
          super
        end
      end
    end
  end
end
