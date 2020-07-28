# frozen_string_literal: true

class Table
  module Helpers
    extend ActiveSupport::Concern

    def destroyable?
      !protected?
    end
  end
end
