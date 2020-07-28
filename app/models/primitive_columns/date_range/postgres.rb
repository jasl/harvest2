# frozen_string_literal: true

class PrimitiveColumns::DateRange
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "daterange"
      end
    end
  end
end
