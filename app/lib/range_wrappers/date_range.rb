# frozen_string_literal: true

module RangeWrappers
  class DateRange < RangeWrapper
    attribute :begin, :datetime
    attribute :end, :datetime

    validates :end,
              timeliness: {
                after: :begin,
                type: :date
              },
              allow_blank: true,
              if: ->(r) { r.begin.present? }

    def begin=(val)
      super(val.try(:in_time_zone)&.utc)
    end

    def end=(val)
      super(val.try(:in_time_zone)&.utc)
    end

    def to_range
      return unless self.begin || self.end

      caster.cast(self.begin)..caster.cast(self.end)
    end

    def serializable_hash
      return unless self.begin || self.end

      {
        "begin" => caster.cast(self.begin),
        "end" => caster.cast(self.end)
      }
    end

    private

      def caster
        ActiveModel::Type.lookup(:date)
      end
  end
end
