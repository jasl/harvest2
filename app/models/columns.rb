# frozen_string_literal: true

module Columns
  BUILTIN_TYPES = [
    BuiltinColumns::PrimaryKey,
    BuiltinColumns::Datetime
  ].freeze

  COMPOSITE_TYPES = [
    CompositeColumns::Address
  ].freeze

  PRIMITIVE_TYPES = [
    PrimitiveColumns::Text, PrimitiveColumns::Boolean, PrimitiveColumns::Decimal,
    PrimitiveColumns::Integer, PrimitiveColumns::Date, PrimitiveColumns::Datetime,
    PrimitiveColumns::TextArray, PrimitiveColumns::BooleanArray, PrimitiveColumns::DecimalArray,
    PrimitiveColumns::IntegerArray, PrimitiveColumns::DateArray, PrimitiveColumns::DatetimeArray,
    PrimitiveColumns::IntegerRange, PrimitiveColumns::DecimalRange, PrimitiveColumns::DateRange,
    PrimitiveColumns::DatetimeRange,
  ].freeze

  REFERENCE_TYPES = [
    ReferenceColumns::ForeignKey
  ].freeze

  NOT_IN_USE_TYPES = [].freeze

  def self.user_creatable_types
    PRIMITIVE_TYPES + COMPOSITE_TYPES + REFERENCE_TYPES
  end
end
