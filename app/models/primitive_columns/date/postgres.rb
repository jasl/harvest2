# frozen_string_literal: true

class PrimitiveColumns::Date
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "date"
      end
    end
  end
end