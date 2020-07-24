# frozen_string_literal: true

class Columns::Decimal
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnQueryConditions::Decimal
    end
  end
end
