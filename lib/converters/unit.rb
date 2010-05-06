class Converters::Unit < Unit
  class << self
    def run!
      Legacy::Unit.all.each do |r|
        params = {
          :name => r.name,
          :description => r.description
        }
        
        if r.product_line?
          params.merge!(:product_line => r.product_line._model_record)
        end
        
        if r.ref_figure?
          params.merge!(:reference_figure => r.ref_figure._model_record)
        end
        
        self.create!(params)
      end
    end
  end
end