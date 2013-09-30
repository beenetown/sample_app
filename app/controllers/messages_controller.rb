class MessagesController < ApplicationController
  def index
    @messages = Message.paginate(page: params[:page])
  end

  def show
    @messages = current_user.messages_list.paginate(page: params[:page])
  end

end