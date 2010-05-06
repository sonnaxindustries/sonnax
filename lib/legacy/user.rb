class Legacy::User < Legacy::Connection
  set_table_name 'users'
  
  def retrieve_password!
    pass_text = "%s-%s" % [self.un, self.pw]
    Digest::SHA1.hexdigest(pass_text)[0..8]
  end
end