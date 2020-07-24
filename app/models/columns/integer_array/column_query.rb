# frozen_string_literal: true

class Columns::IntegerArray
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      nil
    end
  end
end
