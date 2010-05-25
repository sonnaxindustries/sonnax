class PublicationKeywordsController < ApplicationController
  def index
    @keywords = PublicationKeyword.list
  end

  def show
    begin
      @keyword = PublicationKeyword.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

end
