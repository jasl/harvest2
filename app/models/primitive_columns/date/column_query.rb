# frozen_string_literal: true

class PrimitiveColumns::Date
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnFilterConditions::Date
    end
  end
end
