# frozen_string_literal: true

class PrimitiveColumns::Boolean
  module GraphQL
    extend ActiveSupport::Concern

    module ClassMethods
      def graphql_type
        ::GraphQL::Types::Boolean
      end

      def graphql_filter_input_type
        ::Types::InputObjects::ColumnFilters::Boolean
      end
    end
  end
end
