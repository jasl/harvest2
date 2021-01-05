# frozen_string_literal: true

class ReferenceColumn
  module Faker
    extend ActiveSupport::Concern

    include PrimitiveColumn::Faker
  end
end
