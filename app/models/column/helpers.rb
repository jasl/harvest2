# frozen_string_literal: true

class Column
  module Helpers
    extend ActiveSupport::Concern

    def display_configurable?
      display_options.has_member?
    end

    def value_configurable?
      value_options.has_member?
    end

    def storage_configurable?
      storage_options.has_member?
    end

    def validation_configurable?
      validation_options&.has_member?
    end

    def not_null_configurable?
      not_nullable?
    end

    def unique_configurable?
      uniqueable?
    end

    def destroyable?
      !protected?
    end

    def relationship_configurable?
      false
    end

    def relationship_configured?
      true # Only foreign key or similar columns could be false
    end
  end
end
