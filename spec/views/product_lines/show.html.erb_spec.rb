require 'spec_helper'

describe "/product_lines/show" do
  before(:each) do
    render 'product_lines/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/product_lines/show])
  end
end
