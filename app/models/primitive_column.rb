# frozen_string_literal: true

class PrimitiveColumn < Column
  def primitive_column?
    true
  end

  include Postgres
  include Faker
  include DynamicModel

  def not_nullable?
    if new_record?
      !table_ar_model.exists?
    else
      table_ar_model.where(key => nil).size.zero?
    end
  end

  def uniqueable?
    new_record? || !table_ar_model.select(key).group(key).having("count(*) > 1").exists?
  end
end
