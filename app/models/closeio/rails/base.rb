module Closeio
  module Rails
    class Base < OpenStruct
      include DateCoercion
      include Attributes
    end
  end
end