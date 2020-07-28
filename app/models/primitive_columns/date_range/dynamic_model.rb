# frozen_string_literal: true

class PrimitiveColumns::DateRange
  module DynamicModel
    extend ActiveSupport::Concern

    def on_building_ar_model(ar_model)
      super
      ar_model.wrap_attribute symbolized_key, RangeWrappers::DateRange, validate: true
    end
  end
end
