# frozen_string_literal: true

class Column
  module Faker
    extend ActiveSupport::Concern

    def assign_random_value(_record)
      raise NotImplementedError
    end
  end
end
