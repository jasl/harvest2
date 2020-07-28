# frozen_string_literal: true

module BuiltinColumns
  class PrimaryKey < BuiltinColumn
    has_one :relationship, class_name: "Relationship",
            foreign_key: "column_id",
            autosave: true, validate: true,
            dependent: :destroy

    def not_null
      true
    end

    def unique
      true
    end

    include ColumnQuery
  end
end
