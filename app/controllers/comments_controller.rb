class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @project, notice: 'Comentário adicionado com sucesso.'
    else
      redirect_to @project, alert: 'Erro ao adicionar comentário.'
    end
  end

  
  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
