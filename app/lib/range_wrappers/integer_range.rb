# frozen_string_literal: true

module RangeWrappers
  class IntegerRange < RangeWrapper
    attribute :begin, :integer
    attribute :end, :integer

    validates :begin, :end,
              numericality: { only_integer: true },
              allow_blank: true

    validates :end,
              numericality: {
                greater_than: :begin
              },
              allow_blank: true,
              if: ->(r) { r.begin.present? }
  end
end
