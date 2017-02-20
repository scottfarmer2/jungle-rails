require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before(:each) do
      @password = "123456789abcdefghijklmnopqrstuvwxyz"
      @user1 = User.new(id: 1,
                       first_name: "John",
                       last_name: "Wayne",
                       email: "test@test.com",
                       password: @password,
                       password_confirmation: @password
                       )
      @user2 = User.new(id: 2,
                       first_name: "Jane",
                       last_name: "Wayne",
                       email: "test@test.com",
                       password: @password,
                       password_confirmation: @password
                       )
    end

    it "is a valid user" do
      expect(@user1).to be_valid
    end

    it "has a valid first name" do
      @user1.first_name = nil
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:first_name][0] == "can't be blank")
    end

    it "has a valid last name" do
      @user1.last_name = nil
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:last_name][0] == "can't be blank")
    end

    it "has a valid email" do
      @user1.email = nil
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:email][0] == "can't be blank")
    end

    it "should not be valid without a password" do
      @user1.password = nil
      @user1.password_confirmation = nil
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:password][0] == "can't be blank")
    end

    it "should be valid if password is the same" do
      @user1.password = @password
      expect(@user1).to be_valid
      # expect(@user1.errors.messages[:password][0] == "password not same")
    end

    it "should not be valid when different" do
      @user1.password = "anything"
      expect(@user1).to be_invalid
      # expect(@user1.errors.messages[:password][0] == "must match" )
    end

    it "should not be valid because password too short" do
      @user1.password = "boom"
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:password][0] == "too short")
    end

    it "should not be valid if email is not exaclty the same" do
      @user2.save
      @user1.email = @user2.email
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:email][0] == "email in use")
    end

  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @password = "123456789abcdefghijklmnopqrstuvwxyz"
      @user1 = User.new(id: 1,
                       first_name: "John",
                       last_name: "Wayne",
                       email: "test@test.com",
                       password: @password,
                       password_confirmation: @password
                       )
      @user2 = User.new(id: 2,
                       first_name: "Master",
                       last_name: "Chief",
                       email: "test2@test.com",
                       password: @password,
                       password_confirmation: @password
                       )
    end

    it "should authenticate if email the same" do
      @user1.save
      @user = User.authenticate_with_credentials(@user1.email, @user1.password)
      expect(@user).to_not be_nil
      # expect(@user1.errors.messages[:email][0] == "email in use")
    end

    it "password should be right" do
      @user2.save
      @user3 = User.authenticate_with_credentials(@user1.email, @user2.password)
      expect(@user3).to be_nil
    end

    it "should be valid after spaces" do
      @user1.save
      @user = User.authenticate_with_credentials(" test@test.com ", @user1.password)
      expect(@user).to_not be_nil
    end
  end
end






