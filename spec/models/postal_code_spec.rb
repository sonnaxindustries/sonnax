require 'spec_helper'

describe PostalCode do
  before(:each) do
    @valid_attributes = {
      :code => "value for code",
      :city_id => 1,
      :state_id => 1,
      :postal_code_type_id => 1,
      :latitude => 1.5,
      :longitude => 1.5
    }
  end

  it "should create a new instance given valid attributes" do
    PostalCode.create!(@valid_attributes)
  end
end
