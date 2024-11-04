class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      # Detecta menções a usuários na mensagem usando o formato @Nome
      mentioned_names = @comment.body.scan(/@([\w\s]+)/).flatten.map(&:strip) # Captura menções na forma @Nome
      mentioned_users = User.where(name: mentioned_names)

      if mentioned_users.empty?
        logger.debug "Nenhum usuário encontrado para: #{mentioned_names.join(', ')}"
      else
        mentioned_users.each do |mentioned_user|
          create_notification(mentioned_user)
          logger.debug "Notificação criada para: #{mentioned_user.name}"
        end
      end

      redirect_to @project, notice: 'Comentário adicionado com sucesso.'
    else
      redirect_to @project, alert: 'Erro ao adicionar comentário.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def create_notification(recipient)
    # Gera a URL do projeto usando o helper de URL
    project_link = project_url(@project) 
    notification = recipient.notifications.create(
      message: "#{current_user.name} te mencionou em um comentário no projeto: <a href='#{project_link}'>#{@project.title}</a>.",
      read: false
    )

    logger.debug "Notificação criada: #{notification.message} para #{recipient.name}" if notification.persisted?
  end
end
