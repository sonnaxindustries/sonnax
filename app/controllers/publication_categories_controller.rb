class PublicationCategoriesController < ApplicationController
  def index
    @publication_categories = PublicationCategory.root_nodes
  end

  def show
    begin
      @publication_category = PublicationCategory.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
