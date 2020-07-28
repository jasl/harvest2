# frozen_string_literal: true

class PrimitiveColumns::Datetime
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Time.forward(days: 365, period: :all)
    end
  end
end
