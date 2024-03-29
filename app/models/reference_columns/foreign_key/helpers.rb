# frozen_string_literal: true

class ReferenceColumns::ForeignKey
  module Helpers
    extend ActiveSupport::Concern

    def relationship_configurable?
      true
    end

    def relationship_configured?
      present? && relationship.column.present?
    end
  end
end
