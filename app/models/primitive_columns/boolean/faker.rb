# frozen_string_literal: true

class PrimitiveColumns::Boolean
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Boolean.boolean
    end
  end
end
