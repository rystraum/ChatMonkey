class MsgsController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @msg = @chatroom.msgs.create!(params[:msg])
    current_user.msgs << @msg

    respond_to do |format|
      format.html { redirect_to @chatroom }
      format.js { render :nothing => true }
    end
  end

  def fetch
    @msgs = Msg.find_by_sql ("SELECT * FROM msgs WHERE id > '#{params[:msg_id]}' AND chatroom_id = '#{params[:chatroom_id]}'")
    @msgs.each do |m|
      m[:user] = User.find(m.user_id)
    end

    respond_to do |format|
      format.json { render json: @msgs }
    end
  end
end
