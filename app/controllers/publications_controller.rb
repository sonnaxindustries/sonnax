class PublicationsController < ApplicationController
  def index
    @publication_categories = PublicationCategory.root_nodes
  end

  def show
    begin
      @publication = PublicationTitle.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end