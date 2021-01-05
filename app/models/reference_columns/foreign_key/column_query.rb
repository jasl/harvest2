# frozen_string_literal: true

class ReferenceColumns::ForeignKey
  module ColumnQuery
    extend ActiveSupport::Concern

    def query_condition_class
      ::ColumnFilterConditions::ForeignKey
    end
  end
end
