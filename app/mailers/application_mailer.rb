class ApplicationMailer < ActionMailer::Base
  # before_action :authenticate_user!
  
  # binding.pry
  
  default from: User.first.email
  # User.find(current_user.id).email
  layout "mailer"
end
