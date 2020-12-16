# frozen_string_literal: true

class CompositeColumn < Column
  def composite_column?
    true
  end

  include Postgres
  include Faker

  def key_for(sub)
    "#{key}_#{sub}"
  end

  def symbolized_key_for(sub)
    "#{key}_#{sub}".to_sym
  end
end
