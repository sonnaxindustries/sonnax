class Admin::PublicationSubjectsController < Admin::BaseController
  before_filter :retrieve_publication_subject, :only => [:edit, :update, :destroy]

  def index
    @publication_subjects = Admin::PublicationSubject.list
  end

  def new
    @publication_subject = Admin::PublicationSubject.new
  end

  def edit
  end

  def create
    begin
      @publication_subject = Admin::PublicationSubject.new(params[:publication_subject])
      @publication_subject.save!
      flash_and_redirect(admin_publication_subjects_path, 'Subject has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end

  def update
    begin
      @publication_subject.update_attributes!(params[:publication_subject])
      flash_and_redirect(admin_publication_subjects_path, 'Subject has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end

  def destroy
    @publication_subject.destroy

    respond_to do |wants|
      wants.html do
        flash_and_redirect(admin_publication_subjects_path, 'Subject has been removed')
      end
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@publication_subject),
          :message => 'Subject has been removed'
        }
      end
    end
  end

private
  def retrieve_publication_subject
    begin
      @publication_subject = Admin::PublicationSubject.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

  def retrieve_page_details
    @page_details ||= PageDetail.new(:title => 'Publication Subjects', :body_class => 'publication-subjects-home')
  end
end

