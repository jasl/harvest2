# frozen_string_literal: true

class PrimitiveColumn
  module Faker
    extend ActiveSupport::Concern

    def assign_random_value(record)
      return unless record.has_attribute? key

      random_value = generate_random_value
      unless random_value.nil?
        record.send :"#{key}=", random_value
      end
    end

    def generate_random_value; end
  end
end
