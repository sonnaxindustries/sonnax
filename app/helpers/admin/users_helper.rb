module Admin::UsersHelper
  def last_login_at(user)
    if user.last_login_at?
      user.last_login_at.to_s(:month_day_year)
    else
      '<span class="inactive">Never logged in</span>'
    end
  end
  
  def login_count(user)
    if user.login_count?
      pluralize(user.login_count, 'times')
    else
      '<span class="inactive">Never logged in</span>'
    end
  end
end