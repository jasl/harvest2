# frozen_string_literal: true

class PrimitiveColumn
  module Postgres
    extend ActiveSupport::Concern

    included do
      after_create :add_pg_table_column
      before_update :update_pg_table_constraints # TODO: Improve this, some builtin column allow edit constraint

      after_commit :add_or_remove_pg_table_index
      after_commit :remove_pg_table_column, on: :destroy,
                   if: Proc.new {
                     pg_table_exists?(pg_table_name) &&
                       pg_column_exists?(pg_table_name, key)
                   }
    end

    def add_pg_table_column
      pg_add_column pg_table_name, key, pg_type, null: !not_null
      if unique
        pg_add_index pg_table_name, key, unique: true, name: pg_uniqueness_index_name
      end
    end

    def remove_pg_table_column
      remove_pg_table_index
      pg_remove_index pg_table_name, name: pg_uniqueness_index_name rescue ArgumentError
      pg_remove_column pg_table_name, key
    end

    def update_pg_table_constraints
      if not_null_change
        begin
          pg_change_column_null pg_table_name, key, !not_null
        rescue ActiveRecord::NotNullViolation => _ex
          restore_not_null!
          throw(:abort)
        end
      end

      if unique_change
        if unique
          begin
            pg_add_index pg_table_name, key, unique: true, name: "index_unique_#{key}"
          rescue ActiveRecord::RecordNotUnique => _ex
            restore_unique!
            throw(:abort)
          end
        else
          pg_remove_index pg_table_name, name: "index_unique_#{key}" rescue ArgumentError
        end
      end
    end

    def add_or_remove_pg_table_index; end
    def remove_pg_table_index; end

    private

      def pg_type
        raise NotImplementedError
      end
  end
end
