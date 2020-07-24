# frozen_string_literal: true

module Projects
  class ApplicationController < ::ApplicationController
    before_action :set_project
    before_action :set_project_layout_data

    private

      def set_project
        @project = Project.find params[:project_id]
      end

      def set_project_layout_data
        @_sidebar_name = "application"
        @_breadcrumbs =
          [
            { text: "Project", link: projects_path },
            { text: @project.name, link: project_path(@project) }
          ]
      end
  end
end
