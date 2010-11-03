class ContactsController < ApplicationController
  def new
    contact_params = {
      :department_id => (params[:department_id] || 1)
    }
    @contact = Contact.new(contact_params)
  end
  
  def create
    begin
      @contact = Contact.new(params[:contact])
      @contact.save!
      flash_and_redirect(new_contact_path, 'Thanks for contacting us!')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end
end