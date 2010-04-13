require 'spec_helper'

describe State do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :url_friendly => "value for url_friendly",
      :code => "value for code",
      :code => "value for code"
    }
  end

  it "should create a new instance given valid attributes" do
    State.create!(@valid_attributes)
  end
end
