# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# (c) Rystraum Gamonez

class MsgsController < ApplicationController
  respond_to :html, :json
  def create
    @chatroom = Chatroom.find params[:chatroom_id]
    @msg      = @chatroom.msgs.build params[:msg]
    @msg.user = current_user
    @msg.save

    respond_to do |format|
      format.html { redirect_to @chatroom }
      format.js { render :nothing => true }
    end
  end

  def fetch
    @msgs = Msg.where "id > ? AND chatroom_id = ?", params[:msg_id], params[:chatroom_id]
    respond_with @msgs
  end
end

