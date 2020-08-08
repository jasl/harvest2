# frozen_string_literal: true

class Project
  module DynamicModel
    extend ActiveSupport::Concern

    included do
      after_destroy :invalidate_project_models_cluster
    end

    def project_models_cluster
      Globals.project_models_cluster_cache.getset(id) do
        DynamicModelsCluster.build_for(self)
      end
    end

    def invalidate_project_models_cluster
      Globals.project_models_cluster_cache.delete(id)
    end
  end
end
