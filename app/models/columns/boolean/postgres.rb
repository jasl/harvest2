# frozen_string_literal: true

class Columns::Boolean
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "boolean"
      end
    end
  end
end
