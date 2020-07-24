# frozen_string_literal: true

class Columns::DecimalRange
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Number.between(from: -65535.0, to: 0.0)..::Faker::Number.between(from: 1.0, to: 65535.0)
    end
  end
end
