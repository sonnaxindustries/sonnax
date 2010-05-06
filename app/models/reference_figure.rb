class ReferenceFigure < ActiveRecord::Base
  has_attached_file :avatar
  has_attached_file :exploded_view
end
