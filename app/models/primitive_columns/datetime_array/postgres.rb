# frozen_string_literal: true

class PrimitiveColumns::DatetimeArray
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "time[]"
      end
    end
  end
end
