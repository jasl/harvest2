# frozen_string_literal: true

class Table
  module Postgres
    extend ActiveSupport::Concern

    included do
      after_create :create_pg_table
      after_destroy :destroy_pg_table
    end

    def pg_table_name
      [
        self.class.connection.quote_table_name(project.pg_schema_name),
        self.class.connection.quote_table_name(key)
      ].join(".")
    end

    def create_pg_table
      self.class.connection.create_table pg_table_name do |t|
        t.timestamps
      end
    end

    def destroy_pg_table
      self.class.connection.drop_table pg_table_name
    end
  end
end
