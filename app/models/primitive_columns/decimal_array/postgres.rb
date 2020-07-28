# frozen_string_literal: true

class PrimitiveColumns::DecimalArray
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "numeric[]"
      end
    end
  end
end
