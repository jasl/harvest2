# frozen_string_literal: true

class Columns::BooleanArray
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Number.between(from: 0, to: 3).times.map { ::Faker::Boolean.boolean }
    end
  end
end
