# frozen_string_literal: true

class BuiltinColumn < Column
  def builtin_column?
    true
  end

  include Helpers
  include Faker

  class << self
    def user_creatable?
      false
    end
  end
end
