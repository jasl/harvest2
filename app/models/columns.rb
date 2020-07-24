# frozen_string_literal: true

module Columns
  PRIMITIVE_TYPES = [
    Columns::Text, Columns::Boolean, Columns::Decimal, Columns::Integer, Columns::Date, Columns::Datetime,
    Columns::TextArray, Columns::BooleanArray, Columns::DecimalArray, Columns::IntegerArray, Columns::DateArray, Columns::DatetimeArray,
    Columns::IntegerRange, Columns::DecimalRange, Columns::DateRange, Columns::DatetimeRange,
    Columns::ForeignKey
  ].freeze

  BUILTIN_TYPES = [
    Columns::Builtins::PrimaryKey,
    Columns::Builtins::Datetime
  ].freeze

  def self.user_creatable_types
    PRIMITIVE_TYPES
  end
end
