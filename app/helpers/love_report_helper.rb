module LoveReportHelper

  def average_rating(user)
    @user = user
    @entries = Entry.where('linked_profile_id =? and created_at >= ?', @user.id, Time.now.beginning_of_week)
    @entries.average(:rating).round(2) unless @entries.nil? || @entries.count == 0
  end

  def last_weeks_average_rating(user)
    @user = user
    @entries = Entry.where('linked_profile_id =? and created_at BETWEEN ? and ?', @user.id, 1.week.ago.beginning_of_week, 1.week.ago.end_of_week)
    @entries.average(:rating).round(2) unless @entries.nil? || @entries.count == 0
  end


end
