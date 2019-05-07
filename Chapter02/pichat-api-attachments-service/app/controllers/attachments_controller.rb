class AttachmentsController < ApplicationController

  before_action :validate_file_param, only: [:create, :update]

  # GET /messages/:message_id/attachments
  def index
    message = Message.find(params[:message_id])
    json_response(message.attachments)
  end

  # GET /messages/:message_id/attachments/:id
  def show
    message = Message.find(params[:message_id])
    attachment = message.attachments.find(params[:id])
    json_response(attachment)
  end

  # POST /messages/:message_id/attachments
  def create
    message = Message.find_by!(params[:message_id], user_id: current_user.id)
    file = StorageBucket.files.create(
      key:  params[:file][:name],
      body: StringIO.new(Base64.decode64(params[:file][:data]), 'rb'),
      public: true
    )
    attachment = Attachment.new(attachment_params.merge!(message: message))
    attachment.url = file.public_url
    attachment.file_name = params[:file][:name]
    attachment.save
    json_response({ url: attachment.url }, :created)
  end

  # DELETE /messages/:message_id/attachments/:id
  def destroy
    message = Message.find(params[:message_id])
    attachment = message.attachments.find(params[:id])
    attachment.destroy
    head :no_content
  end

  private

  def attachment_params
    params.permit(:media_type, :file)
  end

  def validate_file_param
    if params[:file].nil? or params[:file][:name].nil? or params[:file][:data].nil?
      raise ExceptionHandler::MissingFileParam, "Invalid file data"
    end
  end

end
