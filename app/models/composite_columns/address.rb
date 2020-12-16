# frozen_string_literal: true

module CompositeColumns
  class Address < CompositeColumn
    # serialize :value_configuration, ValueConfiguration
    # serialize :validation_configuration, ValidationConfiguration
    # serialize :storage_configuration, StorageConfiguration

    include Postgres
    # include ColumnQuery
    include Faker
    include DynamicModel

    def unique_configurable?
      false
    end

    def not_nullable?
      if new_record?
        !table_ar_model.exists?
      else
        table_ar_model.where(key_for("address") => nil).size.zero?
      end
    end
  end
end
