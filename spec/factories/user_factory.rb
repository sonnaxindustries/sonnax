Factory.define(:user) do |f|
  f.login 'username'
  f.password '22234abc'
  f.password_confirmation '22234abc'
  f.password_salt 'abcd'
  f.persistence_token 'sdfsdfsdfsf'
  f.login_count 2
  f.failed_login_count 4
  f.last_request_at Time.now
  f.current_login_at Time.now
  f.last_login_at Time.now-3.days
  f.current_login_ip '127.0.0.1'
  f.last_login_ip '127.0.0.1'
end