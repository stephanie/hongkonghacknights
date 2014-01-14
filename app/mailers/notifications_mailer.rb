class NotificationsMailer < ActionMailer::Base

  default :to => "hongkonghacknights@gmail.com"

  def new_message(message)
    @message = message
    mail(:from => "hongkonghacknights@gmail.com", :subject => "A message from #{message.name}")
  end

end