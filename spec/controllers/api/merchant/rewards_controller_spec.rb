require 'spec_helper'

describe Api::Merchant::RewardsController do


  let!(:merchant) { FactoryGirl.create(:merchant) }

  before do
    sign_in merchant
  end

  describe "Create Reward" do

     it "should sucessfully created with valid params data" do
      post :create, reward: {title: "Test Reward", dollar_value: 100, quantity: 100, bean_cost: 200}
      response.should be_success
      data = JSON.parse(response.body)
      data["reward"]["title"].should eq("Test Reward")
    end

    it "should return error when user not signed in yet" do
      sign_out merchant
      post :create, format: :json
      response.should_not be_success
      data = JSON.parse(response.body)
      data["error"].should eq("You need to sign in or sign up before continuing.")
    end
    
  end

   describe "Update Reward" do
     
   end

  describe "Delete Reward" do

   end


end
