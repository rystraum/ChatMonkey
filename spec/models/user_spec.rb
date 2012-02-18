require 'spec_helper'

describe User do
  context "valid attributes" do
    before :each do
      @user = Factory.attributes_for :user
    end

    it "should be successful" do
      User.create! @user
    end
  end

  context "if without a display_name" do
    before :each do
      @user = Factory.attributes_for :user
      @user.delete :display_name
    end

    it "should still be successful" do
      User.create! @user
    end

    it "should have a default display name" do
      user = User.create! @user
      user.display_name.should_not be_nil
    end
  end


end
