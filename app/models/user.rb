class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :entries, dependent: :destroy
  after_create :send_welcome_email


  # Query for entries that the partner has made
  # Any entries that have not been included yet in the daily, will be.
  # otherwise send the entries since the last entry ID
  def partners_entries
    last_report_id = 0
    last_report_id = last_daily_report_id unless last_daily_report_id.nil?
    Entry.where('linked_user_id =? and id > ?', id, last_report_id)
  end

  private
  def send_welcome_email
    WelcomeMailer.welcome(self).deliver_later
  end

end
