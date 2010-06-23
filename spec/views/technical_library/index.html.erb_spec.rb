require 'spec_helper'

describe "/technical_library/index" do
  before(:each) do
    render 'technical_library/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/technical_library/index])
  end
end
