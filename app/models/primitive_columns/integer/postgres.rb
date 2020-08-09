# frozen_string_literal: true

class PrimitiveColumns::Integer
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "int8"
    end
  end
end
