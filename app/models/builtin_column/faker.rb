# frozen_string_literal: true

class BuiltinColumn
  module Faker
    extend ActiveSupport::Concern

    def assign_random_value(_record)
      # opt-out
    end
  end
end
