# frozen_string_literal: true

class Columns::Builtins::Datetime
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      nil
    end
  end
end
