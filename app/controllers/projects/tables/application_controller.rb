# frozen_string_literal: true

module Projects::Tables
  class ApplicationController < ::Projects::ApplicationController
    before_action :set_table
    before_action :set_table_layout_data

    protected

      def set_table
        current_table
      end

      def current_table
        @table ||= @project.tables.find(params[:table_id])
      end

      def set_table_layout_data
        @_breadcrumbs << { text: @table.name, link: project_table_path(@project, @table) }
      end
  end
end
