# frozen_string_literal: true

class RangeWrapper
  include ActiveModel::Model
  include ActiveModel::Attributes

  def to_range
    return unless self.begin || self.end

    self.begin..self.end
  end

  def to_s
    to_range.to_s
  end

  def serializable_hash
    return unless self.begin || self.end

    {
      "begin" => self.begin,
      "end" => self.end
    }
  end

  def ==(comparison_object)
    super ||
      comparison_object.instance_of?(self.class) &&
        self.begin == comparison_object.begin &&
        self.end == comparison_object.end
  end
  alias :eql? :==

  def blank?
    self.begin.nil? && self.end.nil?
  end

  def self.dump(obj)
    obj.to_range
  end

  def self.load(range)
    if range.is_a?(Range) || range.respond_to?(:begin) && range.respond_to?(:end)
      new begin: range.begin, end: range.end
    elsif range.respond_to?(:to_h)
      hash = range.to_h.with_indifferent_access
      new begin: hash[:begin], end: hash[:end]
    else
      new
    end
  end
end
