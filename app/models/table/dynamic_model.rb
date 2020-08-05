# frozen_string_literal: true

class Table
  module DynamicModel
    extend ActiveSupport::Concern

    included do
      after_destroy :invalidate_project_models_cluster
    end

    def project_models_cluster
      Globals.project_models_cluster_cache.getset(project_id) do
        DynamicModelsCluster.new
      end
    end

    def invalidate_project_models_cluster
      Globals.project_models_cluster_cache.delete(project_id)
    end

    def to_ar_model(reload: false)
      invalidate_project_models_cluster if reload
      project_models_cluster[key] ||= DynamicRecord.derive(self)
    end

    def configure_ar_model(model, build_relationships: false)
      if build_relationships
        belongs_to_relationships.each do |relationship|
          ar_model = relationship.table.to_ar_model
          model.belongs_to relationship.foreign_association_name.to_sym, anonymous_class: ar_model, foreign_key: relationship.foreign_column.key, optional: true
        end

        has_many_relationships.each do |relationship|
          ar_model = relationship.foreign_table.to_ar_model
          model.has_many relationship.association_name.to_sym, anonymous_class: ar_model, foreign_key: relationship.foreign_column.key
        end
      end
    end
  end
end
