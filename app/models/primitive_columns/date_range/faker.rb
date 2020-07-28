# frozen_string_literal: true

class PrimitiveColumns::DateRange
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Date.between(from: Date.today, to: 128.days.since)..::Faker::Date.between(from: 129.days.since, to: 365.days.since)
    end
  end
end
