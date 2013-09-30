class Message < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  belongs_to :user, foreign_key: "from_id"
  validates :from_id, presence: true
  validates :content, presence: true
  validates :to_id, presence: true

  def self.messages_for(user)
    where("from_id = ? OR to_id = ?", user.id, user.id)
  end  
end
