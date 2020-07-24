# frozen_string_literal: true

class Projects::Tables::PermissionsController < Projects::Tables::ApplicationController
  before_action :set_permission, only: %i[show edit update destroy]
  before_action :set_permission_layout_data, only: %i[edit update]

  def index
    prepare_meta_tags title: "Permissions"
    @_breadcrumbs << { text: "Permissions" }

    @permissions = @table.permissions.order(:type, :priority)
  end

  def show
    prepare_meta_tags title: "Permission"
    @_breadcrumbs << { text: "Permissions", link: project_table_permissions_path(@project, @table) }
    @_breadcrumbs << { text: @permission.name }
  end

  def new
    prepare_meta_tags title: "New permission"
    @_breadcrumbs << { text: "New" }

    type = Permission.descendants.map(&:to_s).include?(params[:type]) ? params[:type] : nil
    @permission = @table.permissions.new type: type
  end

  def create
    @permission = @table.permissions.new permission_params

    if @permission.save
      redirect_to project_table_permissions_url(@project, @table), notice: "Permission was successfully created."
    else
      prepare_meta_tags title: "New permission"
      @_breadcrumbs << { text: "New" }

      render :new
    end
  end

  def edit
  end

  def update
    if @permission.update(permission_params)
      redirect_back fallback_location: project_table_permissions_url(@project, @table),
                    notice: "Permission was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @permission.destroy
    redirect_to project_table_permissions_url(@project, @table), notice: "Permission was successfully destroyed."
  end

  private

    def set_permission
      @permission = @table.permissions.find(params[:id])
    end

    def set_permission_layout_data
      @_breadcrumbs << { text: @permission.name, link: project_table_permission_path(@project, @table, @permission) }
    end

    def permission_params
      params
        .require(:permission)
        .permit(
          :name, :enabled, :priority, :applicant_query_id, :load_query_id, :identity_required, :type,
          permission_column_settings_attributes: [
            :id, :column_id, :preset_value, :preset_query_id, :preset_query_column_key, :preset_type, :readable, :writable, :required, :type, :_destroy
          ]
        )
    end
end
