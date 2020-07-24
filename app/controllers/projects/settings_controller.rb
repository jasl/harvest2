# frozen_string_literal: true

class Projects::SettingsController < Projects::ApplicationController
  before_action :set_settings_layout_data

  def index
  end

  def update_cors_allow_list
    @cors_allow_list_setting = @project.settings.cors_allow_list
    @cors_allow_list_setting.stringified_value = params.require(:project_setting).fetch(:stringified_value, "")

    if @cors_allow_list_setting.save
      redirect_to project_settings_url(@project), notice: "CORS setting was successfully updated."
    else
      render :index
    end
  end

  private

    def set_settings_layout_data
      prepare_meta_tags title: "Project settings"
      @_breadcrumbs << { text: "Settings" }
    end
end
