# frozen_string_literal: true

module RangeWrappers
  class DecimalRange < RangeWrapper
    attribute :begin, :decimal
    attribute :end, :decimal

    validates :begin, :end,
              numericality: { only_integer: false },
              allow_blank: true

    validates :end,
              numericality: {
                greater_than: :begin
              },
              allow_blank: true,
              if: ->(r) { r.begin.present? }
  end
end
