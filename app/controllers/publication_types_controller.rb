class PublicationTypesController < ApplicationController
  def index
    @types = PublicationType.list
  end

  def show
    begin
      @type = PublicationType.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

end
