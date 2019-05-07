class MessagesController < ApplicationController

  def index
    messages = Message.where(user_id: current_user.id)
    json_response(messages)
  end

  def create
    message = Message.create!(
      params.permit(:body, :user_id).merge!(from_user: current_user))
    json_response(message, :created)
  end

  def show
    message = Message.find_by!(id: params[:id], user_id: current_user.id)
    json_response(message)
  end

  def update
    message = Message.find_by!(id: params[:id], user_id: current_user.id)
    message.update(params.permit(:body, :user_id))
    head :no_content
  end

  def destroy
    message = Message.find_by!(id: params[:id], user_id: current_user.id)
    message.destroy
    head :no_content
  end

end
