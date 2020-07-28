# frozen_string_literal: true

class PrimitiveColumns::DecimalRange
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      nil
    end
  end
end
