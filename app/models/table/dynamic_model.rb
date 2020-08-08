# frozen_string_literal: true

class Table
  module DynamicModel
    extend ActiveSupport::Concern

    included do
      after_destroy :invalidate_project_models_cluster
    end

    def invalidate_project_models_cluster
      project.invalidate_project_models_cluster
    end

    def project_models_cluster
      Globals.project_models_cluster_cache[project_id] || project.project_models_cluster
    end

    def ar_model
      project_models_cluster.fetch_model_by_key key
    end

    # TODO: REMOVE
    def configure_ar_model(model, build_relationships: false)
      if build_relationships
        belongs_to_relationships.each do |relationship|
          ar_model = relationship.table.ar_model
          model.belongs_to relationship.foreign_association_name.to_sym, anonymous_class: ar_model, foreign_key: relationship.foreign_column.key, optional: true
        end

        has_many_relationships.each do |relationship|
          ar_model = relationship.foreign_table.ar_model
          model.has_many relationship.association_name.to_sym, anonymous_class: ar_model, foreign_key: relationship.foreign_column.key
        end
      end
    end
  end
end
