# frozen_string_literal: true

class BuiltinColumns::PrimaryKey
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnQueryConditions::Integer
    end
  end
end
