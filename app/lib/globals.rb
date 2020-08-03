# frozen_string_literal: true

module Globals
  mattr_accessor :table_ar_model_cache, default: LruRedux::TTL::ThreadSafeCache.new(1000, 1.week)
end
