# frozen_string_literal: true

class Columns::Integer
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "int8"
      end
    end
  end
end
