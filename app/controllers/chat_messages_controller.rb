class ChatMessagesController < ApplicationController # rubocop:disable Style/Documentation
  def create
    seek_chat
    chat_message = @chat.chat_messages.new(message: chat_message_params[:message], sender_id: current_user.id)
    
    if chat_message.save
      create_notification(chat_message)  # Adicione a criação da notificação aqui

      Turbo::StreamsChannel.broadcast_action_to(
        "chat_messages_channel_#{@chat.id}",
        action: :prepend,
        target: 'chat-messages-list',
        partial: 'chat_messages/chat_message',
        locals: {
          message: chat_message.message,
          sender_email: current_user.email
        }
      )
    end
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:message, :chat_id)
  end

  def seek_chat
    opt_a_b = '(chats.user_open_chat_id = :user_id AND chats.id = :chat_id)'
    opt_b_a = '(chats.user_destination_chat_id = :user_id AND chats.id = :chat_id)'
    @chat = Chat.where("#{opt_a_b} OR #{opt_b_a}",
                       user_id: current_user.id,
                       chat_id: params[:chat_message][:chat_id]).first
  end

  def create_notification(chat_message)
    recipient_id = @chat.user_open_chat_id == current_user.id ? @chat.user_destination_chat_id : @chat.user_open_chat_id

    # Cria a notificação para o destinatário da mensagem
    recipient = User.find(recipient_id)
    recipient.notifications.create(
      message: "#{current_user.email} enviou uma nova mensagem no chat.",
      read: false
    )
  end
end
