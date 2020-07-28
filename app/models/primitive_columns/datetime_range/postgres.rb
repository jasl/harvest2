# frozen_string_literal: true

class PrimitiveColumns::DatetimeRange
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "tsrange"
      end
    end
  end
end
