class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :content
      t.integer :votes, default: 0

      t.timestamps
    end
  end
end
