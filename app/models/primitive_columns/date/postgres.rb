# frozen_string_literal: true

class PrimitiveColumns::Date
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "date"
    end
  end
end
