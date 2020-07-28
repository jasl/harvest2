# frozen_string_literal: true

class PrimitiveColumns::Date
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Date.forward(days: 365)
    end
  end
end
