# frozen_string_literal: true

module PrimitiveColumns
  class DatetimeRange < PrimitiveColumn
    # serialize :value_configuration, ValueConfiguration
    # serialize :validation_configuration, ValidationConfiguration
    # serialize :storage_configuration, StorageConfiguration

    include Postgres
    include ColumnQuery
    include Faker
    include DynamicModel
  end
end
