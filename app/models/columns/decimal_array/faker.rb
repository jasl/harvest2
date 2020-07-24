# frozen_string_literal: true

class Columns::DecimalArray
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Number.between(from: 0, to: 3).times.map { ::Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    end
  end
end
