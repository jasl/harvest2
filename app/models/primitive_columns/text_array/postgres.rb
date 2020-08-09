# frozen_string_literal: true

class PrimitiveColumns::TextArray
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "text[]"
    end
  end
end
