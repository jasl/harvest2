# frozen_string_literal: true

class Column
  module DynamicModel
    extend ActiveSupport::Concern

    included do
      after_create :unload_cached_ar_model
      after_destroy :unload_cached_ar_model
    end

    def on_building_ar_model(ar_model)
      display_options.on_building_ar_model ar_model, self
      value_options.on_building_ar_model ar_model, self
      validation_options.on_building_ar_model ar_model, self
      storage_options.on_building_ar_model ar_model, self

      if primitive_column?
        if not_null?
          ar_model.validates symbolized_key, presence: true
        end
        if unique?
          ar_model.validates symbolized_key, uniqueness: true
        end
      end
    end

    def unload_cached_ar_model
      table.unload_cached_ar_model
    end
  end
end
