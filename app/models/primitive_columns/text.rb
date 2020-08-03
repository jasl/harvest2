# frozen_string_literal: true

module PrimitiveColumns
  class Text < PrimitiveColumn
    # serialize :value_configuration, ValueConfiguration
    # serialize :validation_configuration, ValidationConfiguration
    # serialize :storage_configuration, StorageConfiguration

    include Postgres
    include ColumnQuery
    include Faker
  end
end
