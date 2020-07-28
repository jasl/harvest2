# frozen_string_literal: true

class PrimitiveColumns::Datetime
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnQueryConditions::Datetime
    end
  end
end
