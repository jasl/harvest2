# frozen_string_literal: true

class PrimitiveColumns::Date
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnQueryConditions::Date
    end
  end
end
