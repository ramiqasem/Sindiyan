ActionMailer::Base.smtp_settings = {
  
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain				=> "Sindiyan.com",
  :user_name            => "ramiqasem@gmail.com",
  :password             => "mayanmj777",
  :authentication       => :plain,
  enable_starttls_auto: => true
  
}