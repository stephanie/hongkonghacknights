class Subscriber < ActiveRecord::Base

  include ActiveModel::Validations

  attr_accessor :email

  after_create :add_subscriber_to_mailchimp
  before_destroy :remove_subscriber_from_mailchimp

  validates :email, :on => :save, :allow_nil => false, :'validators/email' => true
  validates :email, :on => :create, :allow_nil => false, :'validators/email' => true
  validates :email, presence: true
  validates :email, uniqueness: true

  def add_subscriber_to_mailchimp
    mailchimp = Gibbon::API.new(ENV['MAILCHIMP_API_KEY'])
    result = mailchimp.lists.subscribe({
      :id => '30da83867d',
      :email => {:email => self.email},
      :double_optin => false,
      :update_existing => true,
      :send_welcome => true
      })
    Rails.logger.info("Subscribed #{self.email} to MailChimp") if result
  end

  def remove_subscriber_from_mailchimp
    mailchimp = Gibbon::API.new(ENV['MAILCHIMP_API_KEY'])
    result = mailchimp.lists.unsubscribe({
      :id => '30da83867d',
      :email => {:email => self.email},
      :delete_member => true,
      :send_goodbye => false,
      :send_notify => true
      })
    Rails.logger.info("Unsubscribed #{self.email} from MailChimp") if result
  end

end
