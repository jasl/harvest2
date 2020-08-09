# frozen_string_literal: true

class PrimitiveColumns::Boolean
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "boolean"
    end
  end
end
