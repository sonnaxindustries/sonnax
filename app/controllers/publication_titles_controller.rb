class PublicationTitlesController < ApplicationController
  
  def index
    @titles = PublicationTitle.list
  end

  def show
    begin
      @title = PublicationTitle.detail!(params[:id])
    rescue ActiveRecord::RecordInvalid
      render_404
    end
  end
end
