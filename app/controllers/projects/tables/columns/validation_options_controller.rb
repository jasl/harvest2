# frozen_string_literal: true

class Projects::Tables::Columns::ValidationOptionsController < Projects::Tables::Columns::ApplicationController
  before_action :set_options, only: %i[edit update]

  def edit
    prepare_meta_tags title: "Validation"
    @_breadcrumbs << { text: "Validation" }
  end

  def update
    @options.assign_attributes(options_params)

    respond_to do |format|
      if @options.valid? && @column.save(validate: false)
        format.html do
          redirect_to edit_project_table_column_validation_options_url(@project, @table, @column),
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

    def set_options
      @options = @column.value_options
    end

    def options_params
      params.fetch(:options, {}).permit!
    end
end
