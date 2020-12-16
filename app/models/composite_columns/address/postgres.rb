# frozen_string_literal: true

class CompositeColumns::Address
  module Postgres
    extend ActiveSupport::Concern

    def add_pg_table_column
      pg_add_column pg_table_name, key_for("state"), :string, null: !not_null
      pg_add_column pg_table_name, key_for("city"), :string, null: !not_null
      pg_add_column pg_table_name, key_for("zip"), :string, null: !not_null
      pg_add_column pg_table_name, key_for("address"), :string, null: !not_null
      pg_add_column pg_table_name, key_for("address2"), :string
    end

    def remove_pg_table_column
      remove_pg_table_index

      pg_remove_column pg_table_name, key_for("state")
      pg_remove_column pg_table_name, key_for("city")
      pg_remove_column pg_table_name, key_for("zip")
      pg_remove_column pg_table_name, key_for("address")
      pg_remove_column pg_table_name, key_for("address2")
    end

    def update_pg_table_constraints
      if not_null_change
        begin
          pg_change_column_null pg_table_name, key_for("state"), !not_null
          pg_change_column_null pg_table_name, key_for("city"), !not_null
          pg_change_column_null pg_table_name, key_for("zip"), !not_null
          pg_change_column_null pg_table_name, key_for("address"), !not_null
        rescue ActiveRecord::NotNullViolation => _ex
          restore_not_null!
          throw(:abort)
        end
      end
    end
  end
end
