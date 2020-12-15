# frozen_string_literal: true

class PrimitiveColumn
  module DynamicModel
    extend ActiveSupport::Concern

    def on_building_ar_model(ar_model)
      display_configuration.on_building_ar_model ar_model, self
      value_configuration.on_building_ar_model ar_model, self
      validation_configuration.on_building_ar_model ar_model, self
      storage_configuration.on_building_ar_model ar_model, self

      if not_null?
        ar_model.validates symbolized_key, presence: true
      end
      if unique?
        ar_model.validates symbolized_key, uniqueness: true
      end
    end

    def render_display_value(record, view_context: nil)
      record.read_attribute(key)
    end
  end
end
