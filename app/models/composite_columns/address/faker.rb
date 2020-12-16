# frozen_string_literal: true

class CompositeColumns::Address
  module Faker
    extend ActiveSupport::Concern

    def assign_random_value(record)
      record.send :"#{key_for("state")}=", ::Faker::Address.state
      record.send :"#{key_for("city")}=", ::Faker::Address.city
      record.send :"#{key_for("zip")}=", ::Faker::Address.zip
      record.send :"#{key_for("address")}=", ::Faker::Address.street_address
      record.send :"#{key_for("address2")}=", ::Faker::Address.secondary_address
    end
  end
end
