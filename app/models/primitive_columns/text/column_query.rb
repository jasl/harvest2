# frozen_string_literal: true

class PrimitiveColumns::Text
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnQueryConditions::Text
    end
  end
end
