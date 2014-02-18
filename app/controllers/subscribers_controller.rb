class SubscribersController < ApplicationController

  @lists = Gibbon::API.lists
  
  def create
    @subscriber = Subscriber.new(subscriber_params)
    
    if @subscriber.save

      # Tell the UserMailer to send a welcome Email after save
      # SubscriberMailer.mailing_list_email(@subscriber).deliver
      # flash[:notice] = "Successfully saved!"

      redirect_to root_url, :flash => { :success => "Thank you for your interest in Profilr!" }

    else
     redirect_to :back, :flash => { :alert => "Something went wrong. Please try again." }
    end
   
  end

  private
    
  def subscriber_params
    params.require(:subscriber).permit(
      :email
    )
  end

end