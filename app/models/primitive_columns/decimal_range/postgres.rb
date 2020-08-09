# frozen_string_literal: true

class PrimitiveColumns::DecimalRange
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "numrange"
    end
  end
end
