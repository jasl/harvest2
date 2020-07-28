# frozen_string_literal: true

class PrimitiveColumns::BooleanArray
  module GraphQL
    extend ActiveSupport::Concern

    module ClassMethods
      def graphql_type
        [::GraphQL::Types::Boolean]
      end

      def graphql_filter_input_type
        nil
      end
    end
  end
end
