# frozen_string_literal: true

class PrimitiveColumns::Decimal
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnFilterConditions::Decimal
    end
  end
end
