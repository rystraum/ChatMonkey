require 'spec_helper'

describe User do
  before :each do
      @user = Factory.attributes_for :user
  end

  context "valid attributes" do
    it "should be successful" do
      User.create! @user
    end
  end

  context "if without a display_name" do
    before :each do
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

  context "invalid emails" do
    it "should require an email" do
      @user.delete :email
      no_email = User.new @user
      no_email.should_not be_valid
    end

    it "should not accept emails without domains" do
      bad = User.new(@user.merge email: "wrong@")
      bad.should_not be_valid
    end

    it "should not accept emails without username" do
      bad = User.new(@user.merge email: "@domain.com")
      bad.should_not be_valid
    end
  end

  context "passwords" do
    it "should require a password" do
      @user.delete :password
      bad = User.new @user
      bad.should_not be_valid
    end

    it "should require that the password is the same as the confirmation" do
      bad = User.new(@user.merge password_confirmation: @user[:password] + "1" )
      bad.should_not be_valid
    end
  end
end
