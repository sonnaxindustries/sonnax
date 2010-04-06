class RedirectsController < ApplicationController
  
  def check
    begin
      path = "/%s" % params[:path].first
      @redirect = Redirect.check!(path)
      redirect_path = "/%s" % @redirect.new_url
      redirect_to(root_path, :status => @redirect.http_code)
      #redirect_to(redirect_path, :status => @redirect.http_code)
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end