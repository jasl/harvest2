# frozen_string_literal: true

class BuiltinColumns::PrimaryKey
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnFilterConditions::Integer
    end
  end
end
