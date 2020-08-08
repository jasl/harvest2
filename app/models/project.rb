# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :tables, dependent: :destroy

  include Postgres
  include DynamicModel
end
