class CreateMsgs < ActiveRecord::Migration
  def change
    create_table :msgs do |t|
      t.integer :user_id
      t.integer :chatroom_id
      t.text :message

      t.timestamps
    end
  end
end
