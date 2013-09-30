class MessagesController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: :destroy  

  def show
    @messages = current_user.messages_list.paginate(page: params[:page])
  end

  def destroy
    @message.destroy
    redirect_to message_path
  end

  def correct_user
      @message = Message.find(params[:id])
      redirect_to message_path unless @message.from_id == current_user.id
    end
end