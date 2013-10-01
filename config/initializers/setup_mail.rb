ActionMailer::Base.smtp_settings = {
  :address                => "smtp.mail.yahoo.com",
  :port                   => 587,
  :domain                 => "www.mail.yahoo.com",
  :user_name              => ENV["EMAIL"],
  :password               => ENV["PASSWORD"],
  :authentication         => "plain",
  :enable_starttls_auto   => true
}