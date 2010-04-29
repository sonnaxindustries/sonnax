class PublicationSubcategoriesController < ApplicationController
  before_filter :retrieve_parent_category
  
  def index
  end

  def show
    begin
      @publication_subcategory = @publication_category.children.detail!(params[:id])
    rescue ActiveRecord::RecordInvalid
      render_404
    end
  end

private
  def retrieve_parent_category
    begin
      @publication_category = PublicationCategory.detail!(params[:publication_category_id])
    rescue ActiveRecord::RecordInvalid
      render_404
    end
  end
end