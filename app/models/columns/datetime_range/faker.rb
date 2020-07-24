# frozen_string_literal: true

class Columns::DatetimeRange
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Time.between(from: Date.today, to: 128.days.since)..::Faker::Time.between(from: 129.days.since, to: 365.days.since)
    end
  end
end
