# frozen_string_literal: true

class Relationships::BelongsTo
  module Postgres
    extend ActiveSupport::Concern

    included do
      before_update :update_foreign_key
      before_destroy :remove_foreign_key_constraint
    end

    def add_foreign_key_constraint
      return unless table && column

      self.class.connection.add_foreign_key foreign_table.pg_table_name, table.pg_table_name,
                                            column: foreign_column.key, primary_key: column.key
    end

    def remove_foreign_key_constraint
      self.class.connection.remove_foreign_key foreign_table.pg_table_name,
                                               column: foreign_column.key
    rescue
      nil
    end

    def update_foreign_key
      remove_foreign_key_constraint
      add_foreign_key_constraint
    end
  end
end
