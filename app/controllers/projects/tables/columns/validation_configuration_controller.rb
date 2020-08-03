# frozen_string_literal: true

class Projects::Tables::Columns::ValidationConfigurationController < Projects::Tables::Columns::ApplicationController
  before_action :set_configuration, only: %i[edit update]

  def edit
    prepare_meta_tags title: "Validation"
    @_breadcrumbs << { text: "Validation" }
  end

  def update
    @configuration.assign_attributes(options_params)

    respond_to do |format|
      if @configuration.valid? && @column.save(validate: false)
        format.html do
          redirect_to edit_project_table_column_validation_configuration_url(@project, @table, @column),
                      notice: "Column was successfully updated."
        end
      else
        format.html do
          prepare_meta_tags title: "Validation"
          @_breadcrumbs << { text: "Validation" }

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
