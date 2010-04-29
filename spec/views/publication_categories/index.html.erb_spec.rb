require 'spec_helper'

describe "/publication_categories/index" do
  before(:each) do
    render 'publication_categories/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/publication_categories/index])
  end
end
