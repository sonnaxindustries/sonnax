class ContactsController < ApplicationController
  def new
    @contact = Contact.new
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