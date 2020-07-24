# frozen_string_literal: true

class Columns::Boolean
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnQueryConditions::Boolean
    end
  end
end
