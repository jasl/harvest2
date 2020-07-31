# frozen_string_literal: true

class Column
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      nil
    end

    def can_query?
      query_condition_class
    end
  end
end
