# frozen_string_literal: true

class PrimitiveColumns::DatetimeArray
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "time[]"
    end
  end
end
