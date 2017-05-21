class LoveReport < ApplicationMailer
  include LoveReportHelper
  default :from => 'report@treasury.love'

  # send a daily report
  def send_daily_report(user)
    Rails.logger.info "Processing daily report for #{user.email}"
    @user = user
    @entries = @user.partners_entries

    if @entries.count > 0
      mail( :to => @user.email,
            :subject => 'Your daily LoveBank report' )
      Rails.logger.debug "Updating #{@user.email} Daily mailed report ID to #{@entries.last.id}"
      @user.update(last_daily_report_id: @entries.last.id)
    else
      Rails.logger.debug "No entries to include in Daily Report for #{@user.email}. Daily report not mailed"
    end
  end
end
