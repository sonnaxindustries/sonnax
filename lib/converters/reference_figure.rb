class Converters::ReferenceFigure < ReferenceFigure
  class << self
    def run!
      ActiveRecord::Base.connection.execute('TRUNCATE reference_figures')
      Legacy::RefFigure.all.each do |r|
        params = {
          :name => r.name
        }
        
        if r.avatar_file?
          params.merge!(:avatar => r.avatar_file)
        end
        
        if r.text_file_file?
          params.merge!(:exploded_view => r.text_file_file)
        end
        
        self.create!(params)
      end
    end
  end
end