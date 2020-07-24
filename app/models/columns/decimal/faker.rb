# frozen_string_literal: true

class Columns::Decimal
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Number.decimal(l_digits: 4, r_digits: 2)
    end
  end
end
