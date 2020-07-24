# frozen_string_literal: true

class Projects::GraphQLExplorersController < Projects::ApplicationController
  def show
    render layout: false
  end

  helper_method :graphql_endpoint_path
  def graphql_endpoint_path
    services_project_graphql_url(@project)
  end
end
