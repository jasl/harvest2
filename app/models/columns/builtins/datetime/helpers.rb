# frozen_string_literal: true

class Columns::Builtins::Datetime
  module Helpers
    extend ActiveSupport::Concern

    def not_null_configurable?
      false
    end

    def unique_configurable?
      false
    end

    def destroyable?
      false
    end
  end
end
