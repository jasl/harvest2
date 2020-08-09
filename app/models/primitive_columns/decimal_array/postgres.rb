# frozen_string_literal: true

class PrimitiveColumns::DecimalArray
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "numeric[]"
    end
  end
end
