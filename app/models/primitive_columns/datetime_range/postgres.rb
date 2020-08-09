# frozen_string_literal: true

class PrimitiveColumns::DatetimeRange
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "tsrange"
    end
  end
end
