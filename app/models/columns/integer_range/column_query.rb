# frozen_string_literal: true

class Columns::IntegerRange
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      nil
    end
  end
end
