module ApplicationHelper
  def part_class(part)
    class_string = if part.is_new_item?
      'new-item'
    else
      'regular'
    end
  end
end