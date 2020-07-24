# frozen_string_literal: true

class Columns::Datetime
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "timestamp"
      end
    end
  end
end
