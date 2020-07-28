# frozen_string_literal: true

class PrimitiveColumns::TextArray
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Number.between(from: 0, to: 3).times.map { ::Faker::Lorem.sentence }
    end
  end
end
