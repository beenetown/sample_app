class UserMailer < ActionMailer::Base
  default :from => "beenetown@yahoo.com"
  def follower_notification(user)
    mail(:to => user.email, :subject => "New Follower")
  end
end
