# frozen_string_literal: true

class Projects::PersistedQueriesController < Projects::ApplicationController
  before_action :set_persisted_query, only: %i[show edit update destroy]
  before_action :set_persisted_query_layout_data, only: %i[edit update]

  def index
    prepare_meta_tags title: "Persisted queries"
    @_breadcrumbs << { text: "Persisted queries" }

    @persisted_queries = @project.persisted_queries.includes(:table).page(params[:page]).per(params[:per_page])
  end

  def show
    prepare_meta_tags title: "Records"
    @_breadcrumbs << { text: "Persisted queries", link: project_persisted_queries_path(@project) }
    @_breadcrumbs << { text: @persisted_query.name }

    @columns = @persisted_query.table.columns
    @records = @persisted_query.to_query
    @records = @records.page(params[:page]).per(params[:per_page])
  end

  def new
    prepare_meta_tags title: "New persisted query"
    @_breadcrumbs << { text: "New" }

    @table = @project.tables.find_by(id: params[:table_id])
    @persisted_query = @project.persisted_queries.new
    @persisted_query.table = @table if @table
  end

  def create
    @persisted_query = @project.persisted_queries.new persisted_query_params

    if @persisted_query.save
      redirect_to project_persisted_queries_url(@project), notice: "Persisted query was successfully created."
    else
      prepare_meta_tags title: "New persisted query"
      @_breadcrumbs << { text: "New" }

      render :new
    end
  end

  def edit
  end

  def update
    if @persisted_query.update(persisted_query_params)
      redirect_back fallback_location: project_persisted_queries_url(@project),
                    notice: "Persisted query was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @persisted_query.destroy
    redirect_to project_persisted_queries_url(@project), notice: "Persisted query was successfully destroyed."
  end

  private

    def set_persisted_query
      @persisted_query = @project.persisted_queries.find(params[:id])
    end

    def set_persisted_query_layout_data
      @_breadcrumbs << { text: @persisted_query.name, link: project_persisted_query_path(@project, @persisted_query) }
    end

    def persisted_query_params
      params
        .require(:persisted_query)
        .permit(
          :key, :name, :table_id, :matcher,
          column_query_conditions_attributes: [
            :id, :column_id, :type, :_destroy, options: {}
          ]
        )
    end
end
