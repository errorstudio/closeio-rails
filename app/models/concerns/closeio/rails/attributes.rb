module Closeio
  module Rails
    module Attributes
      extend ActiveSupport::Concern

      def attributes
        to_h
      end
    end
  end
end