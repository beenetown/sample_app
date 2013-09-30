class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :user_id
      t.integer :sent_to

      t.timestamps
    end
    add_index :messages, [:sent_to, :created_at]
  end
end
