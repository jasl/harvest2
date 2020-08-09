# frozen_string_literal: true

class PrimitiveColumns::BooleanArray
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "boolean[]"
    end
  end
end
