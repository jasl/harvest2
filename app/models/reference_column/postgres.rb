# frozen_string_literal: true

class ReferenceColumn
  module Postgres
    extend ActiveSupport::Concern

    include PrimitiveColumn::Postgres

    private

      def pg_type
        "int8"
      end
  end
end
