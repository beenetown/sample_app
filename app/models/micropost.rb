class Micropost < ActiveRecord::Base
belongs_to :user
default_scope -> { order('created_at DESC') }
validates :user_id, presence: true
validates :content, presence: true, length: { maximum: 140 }

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships 
                          WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user).in_reply_to(user)
  end

  def self.in_reply_to(user)
    where("in_reply_to IS ? OR in_reply_to = ? OR user_id = ?", nil, "@#{user.id.to_s}-#{user.name.split.join('-')}", user.id) 
  end
end