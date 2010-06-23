class TechnicalLibraryController < ApplicationController
  
  def index
    @publication_categories = PublicationCategory.all
  end
  
  def show
    begin
      @publication_category = PublicationCategory.find_by_url_friendly!(params[:id])
      @publications = @publication_category.publications
      
      @makes = Make.all
      @units = Unit.all
      @subjects = PublicationSubject.all
      
      @form_presenter = TechnicalLibrary::FormPresenter.new(:category => @publication_category, :makes => @makes, :units => @units, :subjects => @subjects)
      
      render @publication_category.underscored_name
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
  def filter
    @publication_category = PublicationCategory.find_by_url_friendly!(params[:id])
    
    if params[:filter] && params[:filter][:make]
      @make = Make.find(params[:filter].fetch('make'))
      @unit_options = @make.units.map { |unit| [unit.name, unit.id] }.push(['-- Select Unit --', '']).reverse
    end
    
    params[:filter].merge!(:category => @publication_category.id) if params[:filter]
    @publications = PublicationTitle.find_by_filter(params[:filter] || {})
    
    @makes = Make.all
    @units = Unit.all
    @subjects = PublicationSubject.all
    
    @form_presenter = TechnicalLibrary::FormPresenter.new(:category => @publication_category, :makes => @makes, :units => @units, :subjects => @subjects)

    respond_to do |wants|
      wants.html do
        render @publication_category.underscored_name
      end
      
      wants.json do
        render :json => {
          :dom_id => dom_id(@publication_category, :publications),
          :unit_select_options => render_to_string(:partial => 'technical_library/unit_options.html.erb', :locals => { :unit_options => @unit_options }),
          :publications_partial => render_to_string(:partial => 'publication_titles/titles_table.html.erb', :locals => { :category => @publication_category, :publications => @publications }),
        }
      end
    end
  end
end