class FixColumnName < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.rename :user_id, :from_id
      t.rename :sent_to, :to_id
    end
  end
end
