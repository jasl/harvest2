# frozen_string_literal: true

class Projects::Tables::RelationshipsController < Projects::Tables::ApplicationController
  def index
    prepare_meta_tags title: "Relationships"
    @_breadcrumbs << { text: "Relationships" }

    @has_many_relationships = @table.has_many_relationships
    @belongs_to_relationships = @table.belongs_to_relationships
  end
end
