# frozen_string_literal: true

module Projects::Tables::Columns
  class ApplicationController < Projects::Tables::ApplicationController
    before_action :set_column
    before_action :forbid_protected!

    protected

      def set_column
        current_column
      end

      def current_column
        @column ||= @table.columns.find(params[:column_id])
      end

      def forbid_protected!
        if @column.protected?
          redirect_to project_table_url(@project, @table),
                      alert: "Protected column can't be edit"
        end
      end
  end
end
