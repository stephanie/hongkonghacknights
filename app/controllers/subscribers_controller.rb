class SubscribersController < ApplicationController

  @lists = Gibbon::API.lists
  
  def create
    begin    
      @subscriber = Subscriber.new(subscriber_params)
      
      if @subscriber.save

        # Tell the UserMailer to send a welcome Email after save
        # SubscriberMailer.mailing_list_email(@subscriber).deliver
        flash[:notice] = "Successfully saved!"
        # redirect_to root_url, notice: 'User was successfully created.' 

        redirect_to root_url, :flash => { :success => "Thank you for your interest in Profilr!" }

      else
        redirect_to root_url, :flash => { :alert => "Something went wrong. Please try again." }
      end
    rescue Exception => e
      puts "Subscribers create #{e.inspect}"
    end
  end

  private
    
    def subscriber_params
      params.require(:subscriber).permit(
        :email
      )
    end

  end