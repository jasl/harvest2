# frozen_string_literal: true

module ColumnFilterConditions
  class Decimal < ScalarColumnFilterCondition
    class Configuration < ColumnFilterConfiguration
      attribute :operator, :string, default: "is_not_null"
      enum operator: {
        is_null: "is_null",
        is_not_null: "is_not_null",
        eq: "eq",
        not_eq: "not_eq",
        gt: "gt",
        gteq: "gteq",
        lt: "lt",
        lteq: "lteq"
      }
      attribute :value, :decimal

      validates :value,
                presence: true,
                if: proc { |r| !r.is_null? && !r.is_not_null? }
    end

    serialize :configuration, Configuration

    generate_matcher_methods "eq", "not_eq", "gt", "gteq", "lt", "lteq"

    include ColumnFilterQueriable::Scalar
  end
end
