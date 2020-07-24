# frozen_string_literal: true

class Columns::DecimalRange
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "numrange"
      end
    end
  end
end
