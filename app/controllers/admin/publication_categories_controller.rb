class Admin::PublicationCategoriesController < Admin::BaseController
  before_filter :retrieve_publication_category, :only => [:edit, :update, :destroy]
  before_filter :retrieve_parent_category_options, :only => [:new, :create, :edit, :update]
  
  def index
    @publication_categories = Admin::PublicationCategory.list
  end

  def new
    @publication_category = Admin::PublicationCategory.new
  end

  def edit
  end
  
  def create
    begin
      @publication_category = Admin::PublicationCategory.new(params[:publication_category])
      @publication_category.save!
      flash_and_redirect(admin_publication_categories_path, 'Category has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end
  
  def update
    begin
      @publication_category.update_attributes!(params[:publication_category])
      flash_and_redirect(admin_publication_categories_path, 'Category has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end
  
  def destroy
     @publication_category.destroy

     respond_to do |wants|
       wants.html do
         flash_and_redirect(admin_publication_categories_path, 'Category has been removed')
       end
       wants.json do
         render :json => {
           :id_to_remove => dom_id(@publication_category),
           :message => 'Category has been removed'
         }
       end
     end
   end

private
  def retrieve_publication_category
    begin
      @publication_category = Admin::PublicationCategory.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
  def retrieve_parent_category_options
    @parent_category_options = Admin::PublicationCategory.options
  end
  
  def retrieve_page_details
    @page_details ||= PageDetail.new(:title => 'Publication Categories', :body_class => 'publication-categories-home')
  end
end