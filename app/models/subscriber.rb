class Subscriber < ActiveRecord::Base

  include ActiveModel::Validations

  attr_accessor :email

  before_create :add_subscriber_to_mailchimp
  before_destroy :remove_subscriber_from_mailchimp

  validates :email, :on => :save, :allow_nil => false, :'validators/email' => true
  validates :email, :on => :create, :allow_nil => false, :'validators/email' => true
  validates :email, presence: true
  validates :email, uniqueness: true

  def add_subscriber_to_mailchimp
    gb = Gibbon::API.new(ENV['MAILCHIMP_API_KEY'])
    gb.lists.subscribe({
      :id => 'd106433d34', 
      :email => {:email => self.email }, 
      :double_optin => false,
      :update_existing => true,
      :send_welcome => true
      })
  end

  def remove_subscriber_from_mailchimp
    gb = Gibbon::API.new(ENV['MAILCHIMP_API_KEY'])
    gb.lists.unsubscribe({
      :id => 'd106433d34', 
      :email => {:email => self.email }, 
      :delete_member => true,
      :send_goodbye => false,
      :send_notify => true
      })
  end

end
