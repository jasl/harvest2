# frozen_string_literal: true

class BuiltinColumn
  module Helpers
    extend ActiveSupport::Concern

    def value_configurable?
      false
    end

    def storage_configurable?
      false
    end

    def validation_configurable?
      false
    end

    def not_null_configurable?
      false
    end

    def unique_configurable?
      false
    end

    def destroyable?
      false
    end

    def relationship_configurable?
      false
    end

    def relationship_configured?
      true # Only foreign key or similar columns could be false
    end
  end
end
