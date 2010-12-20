class PublicationTitlesController < ApplicationController
  
  def index
    @titles = PublicationTitle.list
  end

  def show
    begin
      @title = PublicationTitle.detail!(params[:id])

      params.reverse_merge!(:format => 'html') unless params[:format]

      respond_to do |wants|
        wants.html do
          render :template => 'publication_titles/show.html.erb'
        end
        wants.print do
          render :template => 'publication_titles/show.html.erb', :layout => 'print.html.erb'
        end
      end
    rescue ActiveRecord::RecordInvalid
      render_404
    end
  end
end
