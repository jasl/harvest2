# frozen_string_literal: true

module PrimitiveColumns
  class Date < PrimitiveColumn
    # serialize :value_options, ValueOptions
    # serialize :validation_options, ValidationOptions
    # serialize :storage_options, StorageOptions

    include Postgres
    include ColumnQuery
    include Faker
  end
end
