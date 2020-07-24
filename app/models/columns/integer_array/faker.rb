# frozen_string_literal: true

class Columns::IntegerArray
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Number.between(from: 0, to: 3).times.map { ::Faker::Number.between(from: -65535, to: 65535) }
    end
  end
end
