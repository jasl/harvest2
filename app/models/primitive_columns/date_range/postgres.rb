# frozen_string_literal: true

class PrimitiveColumns::DateRange
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "daterange"
    end
  end
end
