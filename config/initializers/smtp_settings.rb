ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain				=>'smtp.gmail.com',
  :user_name            => 'ramiqasem@gmail.com',
  :password             => 'mayanmj777',
  :authentication       => :plain,
  enable_starttls_auto: true
  
}