# frozen_string_literal: true

module Columns
  PRIMITIVE_TYPES = [
    PrimitiveColumns::Text, PrimitiveColumns::Boolean, PrimitiveColumns::Decimal,
    PrimitiveColumns::Integer, PrimitiveColumns::Date, PrimitiveColumns::Datetime,
    PrimitiveColumns::TextArray, PrimitiveColumns::BooleanArray, PrimitiveColumns::DecimalArray,
    PrimitiveColumns::IntegerArray, PrimitiveColumns::DateArray, PrimitiveColumns::DatetimeArray,
    PrimitiveColumns::IntegerRange, PrimitiveColumns::DecimalRange, PrimitiveColumns::DateRange,
    PrimitiveColumns::DatetimeRange,
    PrimitiveColumns::ForeignKey
  ].freeze

  BUILTIN_TYPES = [
    BuiltinColumns::PrimaryKey,
    BuiltinColumns::Datetime
  ].freeze

  NOT_IN_USE_TYPES = [].freeze

  def self.user_creatable_types
    PRIMITIVE_TYPES
  end
end
