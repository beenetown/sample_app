class Message < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :content, presence: true
  validates :sent_to, presence: true

  def self.messages_for(user)
    where("from_id = ? OR to_id = ?", user.id, user.id)
  end  
end
