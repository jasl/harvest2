# frozen_string_literal: true

module ReferenceColumns
  class ForeignKey < ReferenceColumn
    # serialize :value_configuration, ValueConfiguration
    # serialize :validation_configuration, ValidationConfiguration
    # serialize :storage_configuration, StorageConfiguration

    include ColumnQuery
    include Faker
    include Helpers
    include DynamicModel
  end
end
