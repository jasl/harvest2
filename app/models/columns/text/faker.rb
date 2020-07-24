# frozen_string_literal: true

class Columns::Text
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      ::Faker::Lorem.sentence
    end
  end
end
