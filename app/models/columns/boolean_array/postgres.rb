# frozen_string_literal: true

class Columns::BooleanArray
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "boolean[]"
      end
    end
  end
end
