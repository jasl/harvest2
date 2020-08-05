# frozen_string_literal: true

class PrimitiveColumns::IntegerRange
  module DynamicModel
    extend ActiveSupport::Concern

    def on_building_ar_model(ar_model)
      super
      ar_model.decorate_attribute symbolized_key, RangeWrappers::IntegerRange, validate: true
    end
  end
end
