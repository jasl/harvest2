# frozen_string_literal: true

class ColumnFilterConfiguration < SerializableModel::Base
  attribute :null_value, :boolean, default: false
end
