# frozen_string_literal: true

module Globals
  class << self
    def table_ar_model_cache
      @table_ar_model_cache ||= LruRedux::TTL::ThreadSafeCache.new(1000, 1.week)
    end
  end
end
