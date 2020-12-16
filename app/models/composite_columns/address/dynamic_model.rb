# frozen_string_literal: true

class CompositeColumns::Address
  module DynamicModel
    extend ActiveSupport::Concern

    def on_building_ar_model(ar_model)
      display_configuration.on_building_ar_model ar_model, self
      value_configuration.on_building_ar_model ar_model, self
      validation_configuration.on_building_ar_model ar_model, self
      storage_configuration.on_building_ar_model ar_model, self

      if not_null?
        ar_model.validates symbolized_key_for("state"), presence: true
        ar_model.validates symbolized_key_for("city"), presence: true
        ar_model.validates symbolized_key_for("zip"), presence: true
        ar_model.validates symbolized_key_for("address"), presence: true
      end
    end

    def render_display_value(record, view_context: nil)
      address =
        [
          record.read_attribute(key_for("address")),
          record.read_attribute(key_for("address2"))
        ].reject(&:blank?).compact.join(" ")

      [
        address,
        record.read_attribute(key_for("city")),
        record.read_attribute(key_for("state")),
        record.read_attribute(key_for("zip"))
      ].reject(&:blank?).compact.join(", ")
    end
  end
end
