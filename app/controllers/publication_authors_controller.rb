class PublicationAuthorsController < ApplicationController
  def index
    @authors = PublicationAuthor.list
  end

  def show
    begin
      @author = PublicationAuthor.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

end
