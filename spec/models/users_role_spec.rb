require 'spec_helper'

describe UsersRole do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :role_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    UsersRole.create!(@valid_attributes)
  end
end
