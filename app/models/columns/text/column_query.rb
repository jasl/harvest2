# frozen_string_literal: true

class Columns::Text
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnQueryConditions::Text
    end
  end
end
