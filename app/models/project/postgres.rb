# frozen_string_literal: true

class Project
  module Postgres
    extend ActiveSupport::Concern

    included do
      after_create :create_pg_schema
      after_destroy :destroy_pg_schema
    end

    def pg_schema_name
      unless persisted? || destroyed?
        raise ActiveRecord::RecordNotSaved
      end

      "project_#{id}"
    end

    def create_pg_schema
      self.class.connection.create_schema pg_schema_name
    end

    def destroy_pg_schema
      self.class.connection.drop_schema pg_schema_name
    end
  end
end
