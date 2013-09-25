class Micropost < ActiveRecord::Base
belongs_to :user
default_scope -> { order('created_at DESC') }
validates :user_id, presence: true
validates :content, presence: true, length: { maximum: 140 }

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships 
                          WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id OR in_reply_to = :user_name", 
          user_id: user,
          user_name: '@' + user.id.to_s + '-' + user.name.split.join('-'))
  end

  def self.including_replies(user)
    where("in_reply_to = :user_name OR user_id = :user_id",
            user_name: '@' + user.id.to_s + '-' + user.name.split.join('-'),
            user_id: user)
  end
end
