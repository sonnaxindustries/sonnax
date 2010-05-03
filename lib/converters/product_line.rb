class Converters::ProductLine < ProductLine
  class << self
    def run!
      Legacy::ProductLine.all.each do |m|
        params = {
          :name => m.name,
          :is_active => m.active,
          :sort_order => m.display_order
        }
        self.create!(params)
      end
    end
  end
end