# frozen_string_literal: true

class Columns::TextArray
  module Postgres
    extend ActiveSupport::Concern

    module ClassMethods
      def pg_type
        "text[]"
      end
    end
  end
end
