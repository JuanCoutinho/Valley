class ProjectsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :authenticate_user!, only: [:toggle_like]

  def index
    @projects = if params[:query].present?
                  Project.where('title LIKE ?', "%#{params[:query]}%")
                else
                  Project.all
                end
  end

  def show; end

  def new
    @project = current_user.projects.build
  end

  def edit
    return if @project.user == current_user

    redirect_to projects_path, alert: 'Você não tem permissão para editar este projeto.'
  end

  def create
    @project = current_user.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Projeto foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    redirect_to projects_path, alert: 'Você não tem permissão para atualizar este projeto.' unless @project.user == current_user

    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Projeto foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    unless @project.user == current_user
      redirect_to projects_path, alert: 'Você não tem permissão para excluir este projeto.'
      return
    end

    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Projeto foi excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  def toggle_like # rubocop:disable Metrics/AbcSize
    @project = Project.find(params[:id])

    if @project.liked_by?(current_user)
      # Remove a curtida existente
      @project.likes.find_by(user: current_user).destroy
      flash[:notice] = 'Você descurtiu este projeto.'
    else
      # Adiciona uma nova curtida
      @project.likes.create(user: current_user)
      flash[:notice] = 'Você curtiu este projeto.'
    end

    @project.update_likes_count

    respond_to do |format|
      format.html { redirect_to @project }
      format.js
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :status, :features, :image, :guide, :github_link, :images, :investment)
  end
end
