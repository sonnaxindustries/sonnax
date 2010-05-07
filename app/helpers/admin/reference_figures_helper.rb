module Admin::ReferenceFiguresHelper
  def photo_for(reference_figure)
    if reference_figure.avatar?
      image_tag reference_figure.avatar.url(:tiny) , :class => 'tiny-reference-figure'     
    end
  end
end
