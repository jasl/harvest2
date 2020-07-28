# frozen_string_literal: true

class PrimitiveColumn < Column
  def primitive_column?
    true
  end

  include Postgres
  include Faker
end
