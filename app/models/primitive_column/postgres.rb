# frozen_string_literal: true

class PrimitiveColumn
  module Postgres
    extend ActiveSupport::Concern

    included do
      delegate :pg_table_name, to: :table, allow_nil: false

      after_create :add_pg_table_column
      before_update :update_pg_table_constraints # TODO: Improve this, some builtin column allow edit constraint

      after_commit :add_or_remove_pg_table_index
      after_commit :remove_pg_table_column, on: :destroy
    end

    module ClassMethods
      def pg_type
        raise NotImplementedError
      end
    end

    def pg_uniqueness_index_name
      index_name = "idx_#{table.key}_on_#{key}"
      if index_name.size > 63
        index_name = "idx_#{Digest::SHA2.hexdigest(index_name).first(32)}"
      end

      index_name
    end

    def add_pg_table_column
      self.class.connection.add_column pg_table_name, key, self.class.pg_type, null: !not_null
      if unique
        self.class.connection.add_index pg_table_name, key, unique: true, name: pg_uniqueness_index_name
      end
    end

    def remove_pg_table_column
      return unless self.class.connection.table_exists? pg_table_name
      return unless self.class.connection.column_exists? pg_table_name, key

      remove_pg_table_index
      self.class.connection.remove_index pg_table_name, name: pg_uniqueness_index_name rescue ArgumentError
      self.class.connection.remove_column pg_table_name, key
    end

    def update_pg_table_constraints
      if not_null_change
        begin
          self.class.connection.change_column_null pg_table_name, key, !not_null
        rescue ActiveRecord::NotNullViolation => _ex
          restore_not_null!
          throw(:abort)
        end
      end

      if unique_change
        if unique
          begin
            self.class.connection.add_index pg_table_name, key, unique: true, name: "index_unique_#{key}"
          rescue ActiveRecord::RecordNotUnique => _ex
            restore_unique!
            throw(:abort)
          end
        else
          self.class.connection.remove_index pg_table_name, name: "index_unique_#{key}" rescue ArgumentError
        end
      end
    end

    def add_or_remove_pg_table_index; end
    def remove_pg_table_index; end
  end
end
