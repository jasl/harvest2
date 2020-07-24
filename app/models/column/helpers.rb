# frozen_string_literal: true

class Column
  module Helpers
    extend ActiveSupport::Concern

    def value_configurable?
      value_options.attributes.any? || value_options.class.reflections.any?
    end

    def storage_configurable?
      storage_options.attributes.any? || storage_options.class.reflections.any?
    end

    def validation_configurable?
      validation_options.attributes.any? || validation_options.class.reflections.any?
    end

    def not_null_configurable?
      not_nullable?
    end

    def unique_configurable?
      uniqueable?
    end

    def destroyable?
      true
    end

    def relationship_configurable?
      false
    end

    def relationship_configured?
      true # Only foreign key or similar columns could be false
    end
  end
end
