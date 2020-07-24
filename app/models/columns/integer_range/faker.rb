# frozen_string_literal: true

class Columns::IntegerRange
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Number.between(from: -65535, to: 0)..::Faker::Number.between(from: 1, to: 65535)
    end
  end
end
