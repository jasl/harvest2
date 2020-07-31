# frozen_string_literal: true

class PrimitiveColumns::Integer
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnFilterConditions::Integer
    end
  end
end
