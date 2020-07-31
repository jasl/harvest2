# frozen_string_literal: true

class PrimitiveColumns::Text
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnFilterConditions::Text
    end
  end
end
