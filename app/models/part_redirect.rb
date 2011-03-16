class PartRedirect < ActiveRecord::Base
  belongs_to :old_part, :class_name => 'Part'
  belongs_to :part
end
