class Administrator < ActiveRecord::Base

  include EmailHolder
  include PasswordHolder


  def active?
    # suspendedがfalseの時がtrue
    # start_dateはnowより前
    # end_dateはnil(無いか)
    # 今日より前か
    !suspended?
    # && start_date <= Date.today &&
    #     (end_date.nil? || end_date > Date.today)
  end


end
