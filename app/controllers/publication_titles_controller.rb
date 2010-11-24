class PublicationTitlesController < ApplicationController
  
  def index
    @titles = PublicationTitle.list
  end

  def show
    begin
      @title = PublicationTitle.detail!(params[:id])

      respond_to do |wants|
        wants.html
        wants.print do
          render :template => 'publication_titles/show.html.erb', :layout => 'print.html.erb'
        end
      end
    rescue ActiveRecord::RecordInvalid
      render_404
    end
  end
end
