require 'spec_helper'

describe "/publication_titles/index" do
  before(:each) do
    render 'publication_titles/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/publication_titles/index])
  end
end
