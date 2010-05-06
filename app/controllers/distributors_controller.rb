class DistributorsController < ApplicationController
  def index
    @distributors = Distributor.list
  end

  def show
    begin
      @distributor = Distributor.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end