# frozen_string_literal: true

class Table
  module DynamicModel
    extend ActiveSupport::Concern

    included do
      after_create :invalidate_project_models_cluster
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
  end
end
