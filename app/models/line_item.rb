class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :part
  
  validates_presence_of :order_id
  validates_presence_of :part_id
  validates_uniqueness_of :order_id, :scope => [:part_id]
end
