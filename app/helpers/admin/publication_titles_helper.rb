module Admin::PublicationTitlesHelper
  def date_published_at(title)
    if title.published_at?
      title.published_at.to_s(:month_day_year)
    else
      '<span class="inactive">Not Provided</span>'
    end
  end
end
