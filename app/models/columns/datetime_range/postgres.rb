# frozen_string_literal: true

class Columns::DatetimeRange
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "tsrange"
      end
    end
  end
end
