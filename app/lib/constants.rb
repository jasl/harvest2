# frozen_string_literal: true

module Constants
  # These keys are forbidden in ActiveRecord or GraphQL-Ruby
  RESERVED_KEYS = %w[
    class module def undef begin rescue ensure end
    if unless then elsif else case when while until
    for break next redo retry in do return yield super
    self nil true false and or not alias defined
    BEGIN END __LINE__ __FILE__
    private public protected allocate new parent superclass
  ] + ApplicationRecord.instance_methods(true).map(&:to_s)

  KEY_REGEX = /\A[a-z][a-z_0-9]*\z/

  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/
  USERNAME_REGEX = /\A[a-zA-Z0-9]+\Z/
end
