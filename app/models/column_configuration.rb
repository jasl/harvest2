# frozen_string_literal: true

class ColumnConfiguration < SerializableModel::Base
  def on_building_ar_model(_ar_model, _column); end
end
