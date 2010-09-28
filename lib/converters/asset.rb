class Converters::Asset < Asset
  class << self
    def truncate!
      ActiveRecord::Base.connection.execute('TRUNCATE assets')
    end
  end
end