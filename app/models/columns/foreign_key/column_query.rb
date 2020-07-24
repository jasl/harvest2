# frozen_string_literal: true

class Columns::ForeignKey
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnQueryConditions::ForeignKey
    end
  end
end
