# frozen_string_literal: true

class BuiltinColumns::Datetime
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnFilterConditions::Datetime
    end
  end
end
