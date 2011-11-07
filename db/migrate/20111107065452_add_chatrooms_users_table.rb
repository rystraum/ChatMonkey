class AddChatroomsUsersTable < ActiveRecord::Migration
  def change
    create_table :chatrooms_users, :id => false do |t|
      t.references :chatroom
      t.references :user
    end
  end
end
