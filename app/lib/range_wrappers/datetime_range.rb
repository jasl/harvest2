# frozen_string_literal: true

module RangeWrappers
  class DatetimeRange < RangeWrapper
    attribute :begin, :datetime
    attribute :end, :datetime

    validates :end,
              timeliness: {
                after: :begin,
                type: :datetime
              },
              allow_blank: true,
              if: ->(r) { r.begin.present? }

    def begin=(val)
      super(val.try(:in_time_zone)&.utc)
    end

    def end=(val)
      super(val.try(:in_time_zone)&.utc)
    end
  end
end
