# frozen_string_literal: true

module ColumnFilterConditions
  class Text < ScalarColumnFilterCondition
    class Configuration < ColumnFilterConfiguration
      attribute :operator, :string, default: "is_not_null"
      enum operator: {
        is_null: "is_null",
        is_not_null: "is_not_null",
        eq: "eq",
        not_eq: "not_eq",
        cont: "cont",
        not_cont: "not_cont",
        start_with: "start_with",
        end_with: "end_with"
      }
      attribute :value, :text

      validates :value,
                presence: true,
                if: proc { |r| !r.is_null? && !r.is_not_null? }
    end

    serialize :configuration, Configuration

    generate_matcher_methods "eq", "not_eq", "cont", "not_cont", "start_with", "end_with"

    include ColumnFilterQueriable::Text
  end
end
