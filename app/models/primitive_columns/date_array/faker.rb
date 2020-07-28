# frozen_string_literal: true

class PrimitiveColumns::DateArray
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Number.between(from: 0, to: 3).times.map { ::Faker::Date.forward(days: 365) }
    end
  end
end
