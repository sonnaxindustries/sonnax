class PublicationSubjectsController < ApplicationController
  def index
    @subjects = PublicationSubject.list
  end

  def show
    begin
      @subject = PublicationSubject.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

end
