class UserMailer < ActionMailer::Base
  default :from => "beenetown@yahoo.com"
  def follower_notification(user)
    @user = user
    attachments["rails.png"] = File.read("#{Rails.root}/app/assets/images/rails.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "New Follower") if @user.follower_email == true
  end
end
