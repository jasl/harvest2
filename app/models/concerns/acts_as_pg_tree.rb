# frozen_string_literal: true

module ActsAsPgTree
  extend ActiveSupport::Concern

  included do
    scope :roots, -> { where(parent_id: nil) }
    scope :descendants_of, ->(object) { where("path @> ARRAY[#{object.id}]::bigint[]") }
    scope :descendants_of_with_self, -> (object) { where("path @> ARRAY[#{object.id}]::bigint[]").or(where(id: object.id)) }
    scope :leaves, -> { where(children_count: 0) }

    before_save do
      self.depth = 1 + paths.size
      self.path  = paths.map(&:id)
    end

    # 更改上级节点之后，重新计算依赖该节点的所有节点的path
    after_save do
      if saved_change_to_attribute?(:parent_id)
        self.class.descendants_of(self).each(&:refresh_depth_and_path!)
      end
    end

    # 删除之后，把子节点上移
    after_destroy do
      children.each do |child|
        child.update!(parent: parent)
      end
    end

    validate do |record|
      if parent&.path&.include?(id)
        record.errors.add(:parent_id, "组织不能形成环状！")
      end

      if parent == self
        record.errors.add(:parent_id, "上级不能为自己")
      end
    end
  end

  def refresh_depth_and_path!
    update!(path: paths.map(&:id), depth: 1 + paths.size)
  end

  def descendants
    self.class.descendants_of(self)
  end

  def parents
    self.class.where(id: path)
  end

  def sorted_parents
    self.class.where(id: path).order("array_position('#{self.attributes_before_type_cast['path']}', id)")
  end

  def full_name
    (sorted_parents.to_a + [self]).map(&:name).join("->")
  end

  def parents_with_self
    self.class.where(id: path + [self.id])
  end

  def leave?
    children_count.zero?
  end

  def root?
    parent_id.nil?
  end

  def paths
    list = []
    current_parent = parent
    loop do
      if current_parent
        list.prepend current_parent if current_parent.persisted?
      else
        break
      end
      current_parent = current_parent.parent
    end
    list
  end
end
