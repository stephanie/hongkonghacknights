class ContactController < ApplicationController

  def new
    @message = Message.new
    @subscriber = Subscriber.new
  end

  def create
    @message = Message.new(params[:message])
    
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to('/', :notice => "Thanks for getting in touch!")
    else
      flash.now.alert = "Please fill in all fields."
      render :new
    end
  end

end