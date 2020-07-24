# frozen_string_literal: true

class Columns::DatetimeArray
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Number.between(from: 0, to: 3).times.map { ::Faker::Time.forward(days: 365, period: :all) }
    end
  end
end
