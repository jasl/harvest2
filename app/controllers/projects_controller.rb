# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_project_layout_data, except: %i[destroy]

  # GET /projects
  def index
    @projects = Project.all.order(created_at: :desc).page(params[:page]).per(params[:per_page])
    @_breadcrumbs << { text: "All" }
  end

  # GET /projects/1
  def show
    @_breadcrumbs << { text: @project.name }
  end

  # GET /projects/new
  def new
    @project = Project.new
    @_breadcrumbs << { text: "New" }
  end

  # GET /projects/1/edit
  def edit
    @_breadcrumbs << { text: "Edit" }
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      @_breadcrumbs << { text: "New" }
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      @_breadcrumbs << { text: "Edit" }
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, notice: "Project was successfully destroyed."
  end

  private

    def set_project_layout_data
      prepare_meta_tags title: "Projects"
      @_sidebar_name = "application"
      @_breadcrumbs =
        [
          { text: "Project", link: projects_path },
        ]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      allowed_attributes = [:name, :description]
      if @project.nil? || @project.identity_pool_id.blank?
        allowed_attributes << :identity_pool_id
      end

      params.require(:project).permit(*allowed_attributes)
    end
end
