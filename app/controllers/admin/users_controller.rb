class Admin::UsersController < Admin::BaseController
  before_filter :retrieve_user, :only => [:edit, :update, :destroy]
  before_filter :retrieve_roles, :only => [:new, :edit, :update, :create]
  
  def index
    @users = Admin::User.list
  end

  def new
    @user = Admin::User.new
  end

  def edit
  end
  
  def create
    begin
      @user = Admin::User.new(params[:user])
      @user.save!
      flash_and_redirect(admin_users_path, 'User has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end
  
  def update
    begin
      @user.update_attributes!(params[:user])
      flash_and_redirect(admin_users_path, 'User has been removed')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end
  
  def destroy
     @user.destroy

     respond_to do |wants|
       wants.html do
         flash_and_redirect(admin_users_path, 'User has been removed')
       end
       wants.json do
         render :json => {
           :id_to_remove => dom_id(@user)
         }
       end
     end
   end

private
  def retrieve_user
    begin
      @user = Admin::User.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
  def retrieve_roles
    @roles = Admin::Role.list
  end
  
  def retrieve_page_details
    @page_details ||= PageDetail.new(:title => 'Users', :body_class => 'users-home')
  end
end