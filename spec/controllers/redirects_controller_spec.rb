require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RedirectsController do

  #Delete these examples and add some real ones
  it "should use RedirectsController" do
    controller.should be_an_instance_of(RedirectsController)
  end


  describe "GET 'check'" do
    it "should be successful" do
      get 'check'
      response.should be_success
    end
  end
end
