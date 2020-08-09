# frozen_string_literal: true

class Column
  module DynamicModel
    extend ActiveSupport::Concern

    included do
      after_create :invalidate_project_models_cluster
      after_destroy :invalidate_project_models_cluster
    end

    def on_building_ar_model(ar_model)
      display_configuration.on_building_ar_model ar_model, self
      value_configuration.on_building_ar_model ar_model, self
      validation_configuration.on_building_ar_model ar_model, self
      storage_configuration.on_building_ar_model ar_model, self

      if primitive_column?
        if not_null?
          ar_model.validates symbolized_key, presence: true
        end
        if unique?
          ar_model.validates symbolized_key, uniqueness: true
        end
      end
    end

    def render_value(record, view_context: nil)
      record.read_attribute(key)
    end

    private

      def invalidate_project_models_cluster
        project.invalidate_project_models_cluster
      end
  end
end
