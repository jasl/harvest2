# frozen_string_literal: true

module ColumnFilterConditions
  PRIMITIVE_TYPES = [
    ColumnFilterConditions::Boolean, ColumnFilterConditions::Date, ColumnFilterConditions::Datetime,
    ColumnFilterConditions::Decimal, ColumnFilterConditions::Integer, ColumnFilterConditions::Text,
    ColumnFilterConditions::ForeignKey
  ].freeze

  BUILTIN_TYPES = [
    ColumnFilterConditions::PrimaryKey
  ].freeze
end
