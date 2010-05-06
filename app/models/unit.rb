class Unit < ActiveRecord::Base
  belongs_to :product_line
  belongs_to :reference_figure
end
