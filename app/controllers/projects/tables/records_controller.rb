# frozen_string_literal: true

class Projects::Tables::RecordsController < Projects::Tables::ApplicationController
  before_action :set_model, except: %i[generate]

  def index
    prepare_meta_tags title: "Records"
    @_breadcrumbs << { text: "Records" }

    @columns = @table.columns
    @records = @model.page(params[:page]).per(params[:per_page])
  end

  def destroy
    record = @model.find(params[:id])
    record.destroy

    redirect_back fallback_location: project_table_records_url(@project, @table),
                  notice: "Record was successfully destroyed."
  end

  def generate
    @table.create_random_record

    redirect_to project_table_records_url(@project, @table)
  end

  private

    def set_model
      @model = @table.to_ar_model
    end
end
