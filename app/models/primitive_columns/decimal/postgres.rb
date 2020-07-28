# frozen_string_literal: true

class PrimitiveColumns::Decimal
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "numeric"
      end
    end
  end
end