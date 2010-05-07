class Admin::UnitsMake < ActiveRecord::Base
  belongs_to :unit, :class_name => 'Admin::Unit'
  belongs_to :make, :class_name => 'Admin::Make'
end