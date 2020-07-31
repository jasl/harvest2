# frozen_string_literal: true

module ColumnFilterConditions
  class ForeignKey < ScalarColumnFilterCondition
    class Configuration < ColumnFilterConfiguration
      attribute :operator, :string, default: "is_not_null"
      enum operator: {
        is_null: "is_null",
        is_not_null: "is_not_null",
        eq: "eq",
        not_eq: "not_eq",
      }
      attribute :value, :boolean

      validates :value,
                presence: true,
                if: proc { |r| !r.is_null? && !r.is_not_null? }
    end

    serialize :configuration, Configuration

    generate_matcher_methods "eq", "not_eq"

    def foreign_association_name
      column.relationship.foreign_association_name
    end

    def table_key
      column.relationship.table.key
    end

    include ColumnFilterQueriable::ForeignKey
  end
end
