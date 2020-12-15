# frozen_string_literal: true

class Column
  module DynamicModel
    extend ActiveSupport::Concern

    included do
      after_create :invalidate_project_models_cluster
      after_destroy :invalidate_project_models_cluster
    end

    def on_building_ar_model(ar_model)
      raise NotImplementedError
    end

    def render_display_value(record, view_context: nil)
      raise NotImplementedError
    end

    private

      def invalidate_project_models_cluster
        project.invalidate_project_models_cluster
      end
  end
end
