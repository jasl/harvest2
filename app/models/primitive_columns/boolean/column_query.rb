# frozen_string_literal: true

class PrimitiveColumns::Boolean
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnFilterConditions::Boolean
    end
  end
end
