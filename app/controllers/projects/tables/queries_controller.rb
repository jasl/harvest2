# frozen_string_literal: true

class Projects::Tables::QueriesController < Projects::Tables::ApplicationController
  before_action :set_query, only: %i[show edit update destroy]
  before_action :set_query_layout_data, only: %i[edit update]

  def index
    prepare_meta_tags title: "Queries"
    @_breadcrumbs << { text: "Queries" }

    @queries = @table.queries.page(params[:page]).per(params[:per_page])
  end

  def show
    prepare_meta_tags title: "Records"
    @_breadcrumbs << { text: "Queries", link: project_table_queries_path(@project, @table) }
    @_breadcrumbs << { text: @query.name }

    @records = @query.to_query
    @records = @records.page(params[:page]).per(params[:per_page])
  end

  def new
    prepare_meta_tags title: "New query"
    @_breadcrumbs << { text: "New" }

    @query =
      if params[:query].present?
        @table.queries.new query_params
      else
        @table.queries.new
      end
  end

  def create
    @query = @table.queries.new query_params

    if @query.save
      redirect_to project_table_queries_url(@project, @table), notice: "Query was successfully created."
    else
      prepare_meta_tags title: "New query"
      @_breadcrumbs << { text: "New" }

      render :new
    end
  end

  def edit
  end

  def update
    if @query.update!(query_params)
      redirect_back fallback_location: project_table_queries_url(@project, @table),
                    notice: "Query was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @query.destroy
    redirect_to project_table_queries_url(@project), notice: "Query was successfully destroyed."
  end

  private

    def set_query
      @query = @table.queries.find(params[:id])
    end

    def set_query_layout_data
      @_breadcrumbs << { text: @query.name, link: project_table_query_path(@project, @table, @query) }
    end

    def query_params
      params
        .require(:query)
        .permit(
          :key, :name,
          column_filter_group_attributes: [
            :id, :matcher,
            conditions_attributes: [
              :id, :column_id, :type, :_destroy, configuration: {}
            ]
          ]
        )
    end
end
