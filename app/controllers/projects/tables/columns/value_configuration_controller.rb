# frozen_string_literal: true

class Projects::Tables::Columns::ValueConfigurationController < Projects::Tables::Columns::ApplicationController
  before_action :set_configuration, only: %i[edit update]

  def edit
    prepare_meta_tags title: "Auto-Enter"
    @_breadcrumbs << { text: "Auto-Enter" }
  end

  def update
    @configuration.assign_attributes(options_params)

    respond_to do |format|
      if @configuration.valid? && @column.save(validate: false)
        format.html do
          redirect_to edit_project_table_column_value_configuration_url(@project, @table, @column),
                      notice: "Column was successfully updated."
        end
      else
        format.html do
          prepare_meta_tags title: "Auto-Enter"
          @_breadcrumbs << { text: "Auto-Enter" }

          render :edit
        end
      end
    end
  end

  private

    def set_configuration
      @configuration = @column.value_configuration
    end

    def options_params
      params.fetch(:configuration, {}).permit!
    end
end
