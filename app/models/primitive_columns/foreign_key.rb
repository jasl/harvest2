# frozen_string_literal: true

module PrimitiveColumns
  class ForeignKey < PrimitiveColumn
    # serialize :value_configuration, ValueConfiguration
    # serialize :validation_configuration, ValidationConfiguration
    # serialize :storage_configuration, StorageConfiguration

    has_one :relationship, class_name: "Relationships::BelongsTo",
            foreign_key: "foreign_column_id", inverse_of: :foreign_column,
            autosave: true, validate: true,
            dependent: :destroy

    accepts_nested_attributes_for :relationship

    after_initialize :auto_build_relationship, if: :new_record?

    validate do
      # If column key equal to table key, it will trouble on doing join query
      if relationship.table&.key == key
        errors.add :key, :exclusion
      end
    end

    include Postgres
    include ColumnQuery
    include Faker
    include Helpers

    private

      def auto_build_relationship
        return if relationship

        build_relationship type: "Relationships::BelongsTo", foreign_table: table, project: project
      end
  end
end
