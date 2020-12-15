# frozen_string_literal: true

class Column
  module Postgres
    extend ActiveSupport::Concern

    included do
      delegate :pg_table_name, to: :table, allow_nil: false

      delegate :add_column, :remove_column, :add_index, :remove_index, :change_column_null,
               :table_exists?, :column_exists?,
               to: :pg_connection, prefix: :pg,
               allow_nil: false, private: true
    end

    private

      def pg_connection
        self.class.connection
      end

      def pg_uniqueness_index_name
        index_name = "idx_#{table.key}_on_#{key}"
        if index_name.size > 63
          index_name = "idx_#{Digest::SHA2.hexdigest(index_name).first(32)}"
        end

        index_name
      end
  end
end
