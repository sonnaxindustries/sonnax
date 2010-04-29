require 'spec_helper'

describe PublicationSubcategoriesController do

  #Delete these examples and add some real ones
  it "should use PublicationSubcategoriesController" do
    controller.should be_an_instance_of(PublicationSubcategoriesController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end
end
