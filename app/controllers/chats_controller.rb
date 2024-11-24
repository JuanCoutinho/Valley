class ChatsController < ApplicationController
  def index
    @users = User.all
  end

  def usuarios
    @users = User.all 
  end

  def create
    seek_chat
    return redirect_to(chat_path(id: @chat.id, destination_id: fetch_destination.id)) if @chat.present?

    @chat = Chat.new(user_open_chat: current_user, user_destination_chat: fetch_destination)

    if @chat.save
      redirect_to(chat_path(id: @chat.id, destination_id: fetch_destination.id))
    else
      @users = current_user.followings | current_user.followers
      render :index
    end
  end

  def show
    seek_chat
    if @chat.nil?
      redirect_to chats_path, alert: "Conversa não encontrada."
      return
    end

    @destination = fetch_destination
    if @destination.nil?
      redirect_to chats_path, alert: "Usuário de destino não encontrado."
      return
    end

    @users = User.all
    @chat_messages = @chat.chat_messages.order(created_at: :desc)
  end

  private

  def fetch_destination
    return nil unless params[:destination_id].present?

    @destination ||= User.find_by(id: params[:destination_id])
  end

  def seek_chat
    destination = fetch_destination
    return unless destination # Não continue se o destino for nil

    opt_a_b = '(chats.user_open_chat_id = :open AND chats.user_destination_chat_id = :destination)'
    opt_b_a = '(chats.user_open_chat_id = :destination AND chats.user_destination_chat_id = :open)'

    @chat = Chat.where("#{opt_a_b} OR #{opt_b_a}", open: current_user.id, destination: destination.id).first
  end
end
