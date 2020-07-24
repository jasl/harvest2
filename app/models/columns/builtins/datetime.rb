# frozen_string_literal: true

module Columns::Builtins
  class Datetime < Columns::Datetime
    include Faker
    include Helpers

    class << self
      def builtin?
        true
      end

      def user_creatable?
        false
      end
    end
  end
end
