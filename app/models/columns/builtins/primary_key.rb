# frozen_string_literal: true

module Columns::Builtins
  class PrimaryKey < Column
    has_one :relationship, class_name: "Relationship",
            foreign_key: "column_id",
            autosave: true, validate: true,
            dependent: :destroy

    def not_nullable?
      true
    end

    def uniqueable?
      true
    end

    def not_null
      true
    end

    def unique
      true
    end

    include ColumnQuery
    include Helpers

    class << self
      def builtin?
        true
      end

      def user_creatable?
        false
      end
    end
  end
end
