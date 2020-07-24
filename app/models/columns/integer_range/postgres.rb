# frozen_string_literal: true

class Columns::IntegerRange
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "int8range"
      end
    end
  end
end
