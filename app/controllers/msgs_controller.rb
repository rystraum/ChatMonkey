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

end
