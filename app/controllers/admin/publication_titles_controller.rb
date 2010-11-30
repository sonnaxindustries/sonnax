class Admin::PublicationTitlesController < Admin::BaseController
  before_filter :retrieve_publication_title, :only => [:edit, :update, :destroy, :remove_pdf]
  before_filter :retrieve_subject_options, :retrieve_category_options, :retrieve_author_options, :only => [:edit, :update, :new, :create]
  
  def index
    @publication_titles = Admin::PublicationTitle.list(params)
  end
  
  def search
    @publication_titles = Admin::PublicationTitle.search(params[:q], :page => params[:page])
    render :action => :index
  end

  def new
    @publication_title = Admin::PublicationTitle.new
  end

  def edit
  end
  
  def create
    begin
      @publication_title = Admin::PublicationTitle.new(params[:publication_title])
      @publication_title.save!
      flash_and_redirect(admin_publication_titles_path, 'Title has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end    
  end
  
  def update
    begin
      @publication_title.update_attributes!(params[:publication_title])
      flash_and_redirect(admin_publication_titles_path, 'Title has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end
  
  def remove_pdf
    @publication_title.remove_pdf!
    
    respond_to do |wants|
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@publication_title, :pdf),
          :message => 'PDF has been removed'
        }
      end
    end
  end
  
  def destroy
    @publication_title.destroy
    
    respond_to do |wants|
      wants.html do
        flash_and_redirect(admin_publication_titles_path, 'Title has been removed')
      end
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@publication_title),
          :message => 'Title has been removed'
        }
      end
    end
  end
  
private
  def retrieve_publication_title
    begin
      @publication_title = Admin::PublicationTitle.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
  def retrieve_page_details
    @page_details ||= PageDetail.new(:title => 'Publication Titles', :body_class => 'publication-titles-home')
  end

  def retrieve_subject_options
    @subject_options = Admin::PublicationSubject.options
  end

  def retrieve_author_options
    @author_options = Admin::PublicationAuthor.options
  end

  def retrieve_category_options
    @category_options = Admin::PublicationCategory.list_options
  end
end
