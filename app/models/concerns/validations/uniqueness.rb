# frozen_string_literal: true

module Validations::Uniqueness
  extend ActiveSupport::Concern

  included do
    attribute :uniqueness, :boolean, default: false
  end

  def interpret_to(model, field_name, _accessibility, _options = {})
    super
    return unless uniqueness

    # TODO:
    # model.validates field_name, presence: true
  end
end
