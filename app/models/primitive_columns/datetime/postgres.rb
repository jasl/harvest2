# frozen_string_literal: true

class PrimitiveColumns::Datetime
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "timestamp"
    end
  end
end
