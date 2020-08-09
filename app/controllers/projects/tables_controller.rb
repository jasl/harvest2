# frozen_string_literal: true

class Projects::TablesController < Projects::ApplicationController
  before_action :set_table, only: %i[show edit update destroy]
  before_action :set_table_layout_data, only: %i[edit update]

  def index
    prepare_meta_tags title: "Tables"
    @_breadcrumbs << { text: "Tables" }

    @tables = @project.tables.page(params[:page]).per(params[:per_page])
  end

  def show
    @_breadcrumbs << { text: @table.name }

    @columns = @table.columns
  end

  def new
    prepare_meta_tags title: "New table"
    @_breadcrumbs << { text: "New" }

    @table = @project.tables.new
  end

  def edit
    prepare_meta_tags title: "Edit table"
    @_breadcrumbs << { text: "Edit" }
  end

  def create
    @table = @project.tables.new(table_params_for_create)

    respond_to do |format|
      if @table.save
        format.html do
          redirect_to project_table_url(@project, @table), notice: "Table was successfully created."
        end
      else
        format.html do
          prepare_meta_tags title: "New table"
          @_breadcrumbs << { text: "New" }

          render :new
        end
      end
    end
  end

  def generate
    @table = Table.create_random_for(@project)

    redirect_to project_table_url(@project, @table), notice: "Table was successfully created."
  end

  def update
    respond_to do |format|
      if @table.update(table_params)
        format.html do
          redirect_to project_table_url(@project, @table), notice: "Table was successfully updated."
        end
      else
        format.html do
          render :edit
        end
      end
    end
  end

  def destroy
    @table.destroy

    respond_to do |format|
      format.html do
        redirect_to project_url(@project), notice: "Table was successfully destroyed."
      end
    end
  end

  private

    def set_table
      @table = @project.tables.find(params[:id])
    end

    def table_params_for_create
      params.require(:table).permit(:key, :name, :description)
    end

    def table_params
      params.require(:table).permit(:name, :description, :thumbnail_column_id)
    end

    def set_table_layout_data
      @_breadcrumbs << { text: @table.name, link: project_table_path(@project, @table) }
    end
end
