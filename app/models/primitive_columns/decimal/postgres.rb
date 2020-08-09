# frozen_string_literal: true

class PrimitiveColumns::Decimal
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "numeric"
    end
  end
end
