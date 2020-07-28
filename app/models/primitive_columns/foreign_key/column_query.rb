# frozen_string_literal: true

class PrimitiveColumns::ForeignKey
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnQueryConditions::ForeignKey
    end
  end
end
