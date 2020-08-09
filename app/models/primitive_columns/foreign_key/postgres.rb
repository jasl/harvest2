# frozen_string_literal: true

class PrimitiveColumns::ForeignKey
  module Postgres
    extend ActiveSupport::Concern

    def pg_type
      "int8"
    end
  end
end
