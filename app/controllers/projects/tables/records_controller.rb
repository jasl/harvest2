# frozen_string_literal: true

class Projects::Tables::RecordsController < Projects::Tables::ApplicationController
  before_action :set_model, except: %i[generate]
  before_action :set_record, only: %i[show edit update destroy]

  def index
    prepare_meta_tags title: "Records"
    @_breadcrumbs << { text: "Records" }

    @query =
      if params[:query].present?
        @table.queries.new query_params
      else
        @table.queries.new
      end
    @query.one_time_usage = true

    @records =
      if @query.valid?
        @query.to_query
      else
        @model.none
      end
    @records = @records.preload_all_belongs_to
    @records = @records.page(params[:page]).per(params[:per_page])
  end

  def show
    prepare_meta_tags title: "Show record"
    @_breadcrumbs << { text: @record.id }
  end

  def new
    prepare_meta_tags title: "New record"
    @_breadcrumbs << { text: "New" }

    @record = @model.new
  end

  def create
    @record = @model.new record_params

    respond_to do |format|
      if @record.save
        format.html do
          redirect_to project_table_records_url(@project, @table),
                      notice: "Record was successfully created."
        end
      else
        format.html do
          prepare_meta_tags title: "New record"
          @_breadcrumbs << { text: "New" }

          render :new
        end
      end
    end
  end

  def edit
    prepare_meta_tags title: "Editing record"
    @_breadcrumbs << { text: "Editing" }
  end

  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html do
          redirect_to project_table_records_url(@project, @table),
                      notice: "Record was successfully updated."
        end
      else
        format.html do
          prepare_meta_tags title: "Editing record"
          @_breadcrumbs << { text: "Editing" }

          render :edit
        end
      end
    end
  end

  def destroy
    @record.destroy

    if @record.destroyed?
      redirect_back fallback_location: project_table_records_url(@project, @table),
                    notice: "Record was successfully destroyed."
    else
      redirect_back fallback_location: project_table_records_url(@project, @table),
                    notice: "Record can't be destroyed."
    end
  end

  def generate
    @table.create_random_record

    redirect_to project_table_records_url(@project, @table)
  end

  private

    def set_model
      @model = @table.ar_model
    end

    def set_record
      @record = @model.find(params[:id])
    end

    def record_params
      params.require(:record).permit!
    end

    def query_params
      params
        .require(:query)
        .permit(
          column_filter_group_attributes: [
            :id, :matcher,
            conditions_attributes: [
              :id, :column_id, :type, :_destroy, configuration: {}
            ]
          ]
        )
    end
end
