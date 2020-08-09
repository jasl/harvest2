# frozen_string_literal: true

class PrimitiveColumns::IntegerArray
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "int8[]"
    end
  end
end
