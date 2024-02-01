# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_message, only: %i(show edit update destroy)

  # GET /messages or /messages.json
  def index
    @pagy, @messages = pagy(Message.where("body like ?", "%#{params[:body]}%").order(id: :desc))
  end

  # GET /messages/1 or /messages/1.json

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
    # return root_path if turbo_frame_request?
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@message, partial: "messages/form",
locals: {message: @message})
      end
    end
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        flash[:notice] = "Messages #{@message.id} is created"
        format.turbo_stream do
          render turbo_stream: [turbo_stream.append("messages", partial: "messages/message",
locals: {message: @message})]
        end
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("new_message", partial: "messages/form", locals: {message: @message})
          ]
        end
      end
    end
  end

  # def handle_create_success
  #   [
  #     turbo_stream.update("new_message", partial: "messages/form", locals: {message: Message.new}),
  #     turbo_stream.append("messages", partial: "messages/message", locals: {message: @message}),
  #     turbo_stream.update("messages_counter", Message.count),
  #     turbo_stream.update("flash", partial: "layouts/flash")
  #   ]
  # end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update(@message, partial: "messages/message", locals: {message: @message}),
                                turbo_stream.update("notice",
                                                    "Messages #{@message.id} is successfully updated.")]
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@message, partial: "messages/form",
locals: {message: @message})
        end
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.remove(@message),
                              turbo_stream.update("messages_counter", Message.count),
                              turbo_stream.update("notice", "Messages #{@message.id} was successfully destroyed.")]
      end
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:body)
  end
end
