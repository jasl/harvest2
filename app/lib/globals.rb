# frozen_string_literal: true

module Globals
  mattr_accessor :project_models_cluster_cache, default: LruRedux::TTL::ThreadSafeCache.new(1000, 1.week)
end
