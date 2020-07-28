# frozen_string_literal: true

class PrimitiveColumns::ForeignKey
  module Faker
    extend ActiveSupport::Concern

    def generate_random_value
      target_table = relationship.table
      return unless target_table
      target_table.to_ar_model.order("RANDOM()").first&.id
    end
  end
end
