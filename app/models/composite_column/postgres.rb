# frozen_string_literal: true

class CompositeColumn
  module Postgres
    extend ActiveSupport::Concern

    included do
      after_create :add_pg_table_column
      before_update :update_pg_table_constraints

      after_commit :add_or_remove_pg_table_index
      after_commit :remove_pg_table_column, on: :destroy
    end

    def add_pg_table_column
    end

    def remove_pg_table_column
    end

    def update_pg_table_constraints
    end

    def add_or_remove_pg_table_index; end
    def remove_pg_table_index; end
  end
end
