class AddIndexOverUserIdAndChatroomIdOnMsgs < ActiveRecord::Migration
  def change
    add_index :msgs, [:user_id, :chatroom_id]
  end
end
