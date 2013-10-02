require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings = {
  :address                => "smtp.mail.yahoo.com",
  :port                   => 587,
  :domain                 => "www.mail.yahoo.com",
  :user_name              => ENV["EMAIL"],
  :password               => ENV["PASSWORD"],
  :authentication         => "plain",
  :enable_starttls_auto   => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?