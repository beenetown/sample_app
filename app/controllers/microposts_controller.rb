class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def index
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.in_reply_to = @micropost.content.split.first if reply?
    if message?
      # message.save with micropost_params
      @message = current_user.messages.build(from_id: @micropost.user_id,
                                             to_id: message_to,
                                             content: @micropost.content)
      if @message.save
        flash[:success] = "Message Sent, but not really yet!"
        redirect_to root_url
      else
        flash[:error] = "Message not sent."
        redirect_to root_url
      end
    else
      if @micropost.save
        flash[:success] = "Micropost created!"
        redirect_to root_url
      else
        @feed_items = []
        render 'static_pages/home'
      end
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def reply?
      is_at = @micropost.content.split(//).first 
      if is_at == '@'
        true
      end
    end

    def message?
      if /d[\d+]-(\w+)-(\w+)/.match(@micropost.content)
        true
      end
    end

    def message_to
      @micropost.content.scan(/(?<=^d)\d/)[0].to_i
    end
end