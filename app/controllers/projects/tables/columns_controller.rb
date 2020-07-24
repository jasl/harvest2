# frozen_string_literal: true

class Projects::Tables::ColumnsController < Projects::Tables::ApplicationController
  before_action :set_column_layout_data, except: %i[destroy]
  before_action :set_column, only: %i[edit update destroy]
  before_action :forbid_no_destroyable!, only: %i[destroy]
  before_action :set_column_layout_data, only: %i[edit update]

  def new
    prepare_meta_tags title: "New column"
    @_breadcrumbs << { text: "New" }

    type = Column.descendants.select(&:user_creatable?).map(&:to_s).include?(params[:type]) ? params[:type] : nil
    @column = @table.columns.new type: type
  end

  def edit
    prepare_meta_tags title: "Edit column"
    @_breadcrumbs << { text: "Edit" }
  end

  def create
    @column = @table.columns.new(column_params_for_create)

    respond_to do |format|
      if @column.save
        format.html do
          redirect_to edit_project_table_column_url(@project, @table, @column),
                      notice: "Column was successfully created."
        end
      else
        format.html do
          prepare_meta_tags title: "New column"
          @_breadcrumbs << { text: "New" }

          render :new
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @column.update(column_params_for_update)
        format.html do
          redirect_to edit_project_table_column_url(@project, @table, @column),
                      notice: "Column was successfully updated."
        end
      else
        format.html do
          prepare_meta_tags title: "Edit column"
          @_breadcrumbs << { text: "Edit" }

          render :edit
        end
      end
    end
  end

  def destroy
    @column.destroy
    respond_to do |format|
      format.html do
        redirect_to project_table_url(@project, @table),
                    notice: "Column was successfully destroyed."
      end
    end
  end

  private

    def set_columns_layout_data
      @_breadcrumbs << { text: "Columns", link: project_table_path(@project, @table) }
    end

    def set_column_layout_data
      @_breadcrumbs << { text: @column.name, link: edit_project_table_column_path(@project, @table, @column) }
    end

    def set_column
      @column = @table.columns.find(params[:id])
    end

    def column_params_for_update
      params
        .fetch(:column, {})
        .permit(
          :name, :description, :not_null, :unique,
          relationship_attributes: %i[table_id _destroy]
        )
    end

    def column_params_for_create
      params
        .fetch(:column, {})
        .permit(
          :key, :name, :description, :type, :not_null, :unique,
          relationship_attributes: %i[table_id _destroy]
        )
    end

    def forbid_no_destroyable!
      unless @column.destroyable?
        redirect_to project_table_path(@project, @table),
                    alert: "The column can't be destroy."
      end
    end
end
