module Admin::PublicationTitlesHelper
  def date_published_at(title)
    if title.published_at?
      title.published_at.to_s(:month_day_year)
    else
      '<span class="inactive">Not Provided</span>'
    end
  end
  
  def publication_published_at(publication)
    if publication.published_at?
      publication.published_at.to_s(:month_year)
    else
      '<span class="inactive">Not Provided</span>'
    end
  end
  
  def pdf_details(publication)
    if publication.pdf?
      "<span class=\"pdf-size\"><img src=\"/images/icons/pdf.gif\" alt=\"%s\"> (%s)</span>" % [publication.title, number_to_human_size(publication.pdf_file_size)]
    end
  end
  
  def publication_authors_list(publication)
    if publication.authors?
      publication.authors.map { |author| author.full_name }.to_sentence
    else
      '<span class="inactive">Not Provided</span>'
    end
  end
end