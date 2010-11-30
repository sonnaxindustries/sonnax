class Admin::PublicationAuthorsController < Admin::BaseController
  before_filter :retrieve_publication_author, :only => [:edit, :update, :destroy]

  def index
    @publication_authors = Admin::PublicationAuthor.list
  end

  def new
    @publication_author = Admin::PublicationAuthor.new
  end

  def edit
  end

  def create
    begin
      @publication_author = Admin::PublicationAuthor.new(params[:publication_author])
      @publication_author.save!
      flash_and_redirect(admin_publication_authors_path, 'Author has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end

  def update
    begin
      @publication_author.update_attributes!(params[:publication_author])
      flash_and_redirect(admin_publication_authors_path, 'Author has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end

  def destroy
    @publication_author.destroy

    respond_to do |wants|
      wants.html do
        flash_and_redirect(admin_publication_authors_path, 'Author has been removed')
      end
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@publication_author),
          :message => 'Author has been removed'
        }
      end
    end
  end

private
  def retrieve_publication_author
    begin
      @publication_author = Admin::PublicationAuthor.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

  def retrieve_page_details
    @page_details ||= PageDetail.new(:title => 'Publication Authors', :body_class => 'publication-authors-home')
  end
end
