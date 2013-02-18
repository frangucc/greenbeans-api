require 'spec_helper'

describe Api::Merchant::RewardsController do


  let!(:merchant) { FactoryGirl.create(:merchant) }

  before do
    @expiry_time = Time.now + 2400
    sign_in merchant
  end

  describe "Create Reward" do

    it "should sucessfully created with valid params data" do
      post :create, reward: {title: "Test Reward", dollar_value: 100, quantity: 100, bean_cost: 200, expiration_date: @expiry_time}
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

    it "should return error when user does not provide title, dollar value, quantity, expiration date and bean cost" do
      post :create, reward: {}
      response.should be_success
      data = JSON.parse(response.body)
      data["message"].should include("Title can't be blank")
      data["message"].should include("Dollar value can't be blank")
      data["message"].should include("Quantity can't be blank")
      data["message"].should include("Bean cost can't be blank")
      data["message"].should include("Expiration date can't be blank")
    end

    it "should not create reward if drawing time has invalid format" do
      reward_hash = {title: "Test Reward", dollar_value: 100, quantity: 100, bean_cost: 200, expiration_date: "2013 22-13 07:00:08"}
      post :create, reward: reward_hash
      response.should be_success
      data = JSON.parse(response.body)      
      data["status"].should eq(205)
      data["message"].should include("Expiration date Format should be in 'yyyy-mm-dd hh:mm:ss'")
    end

    it "should not create reward if dollar value,quantity,bean_cost  are not numbers" do
      reward_hash = {title: "Test Reward", dollar_value: "test", quantity: "test", bean_cost: "test", expiration_date: @expiry_time}
      post :create, reward: reward_hash
      response.should be_success
      data = JSON.parse(response.body)      
      data["status"].should eq(205)
      data["message"].should include("Dollar value is not a number")
      data["message"].should include("Quantity is not a number")
      data["message"].should include("Bean cost is not a number")
    end

  end

  describe "Update Reward" do
    it "should update reward" do
      reward = FactoryGirl.create(:reward, merchant: merchant)      
      reward_hash = {title: "New Test Reward"}
      put :update, id: reward.id, reward: reward_hash
      data = JSON.parse(response.body)
      data["status"].should eq(200)      
      updated_raffle = Reward.find reward.id
      updated_raffle.title.should eq "New Test Reward"
      data["message"].should eq("updated reward successfully.")
    end

     it "should return error when user not signed in yet" do
      sign_out merchant
      reward = FactoryGirl.create(:reward, merchant: merchant)      
      reward_hash = {title: "New Test Reward"}
      put :update, id: reward.id, raffle: reward_hash, format: :json
      response.should_not be_success
      data = JSON.parse(response.body)
      data["error"].should eq("You need to sign in or sign up before continuing.")
    end

     it "should not update with blank title, dollar value, quantity, bean_cost" do
      reward = FactoryGirl.create(:reward, merchant: merchant)      
      reward_hash = {title: "Test Reward", dollar_value: "", quantity: "", bean_cost: "", expiration_date: @expiry_time}
      put :update, id: reward.id, reward: reward_hash
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("Dollar value can't be blank")
      data["message"].should include("Quantity can't be blank")
      data["message"].should include("Bean cost can't be blank")
    end


     it "should not update with negative values for title, dollar value, quantity, bean_cost" do
      reward = FactoryGirl.create(:reward, merchant: merchant)
      reward_hash = {title: "Test Reward", dollar_value: -1, quantity: -20, bean_cost: -50, expiration_date: @expiry_time}
      put :update, id: reward.id, reward: reward_hash
      data = JSON.parse(response.body)
      p "-" * 50
      puts data.inspect
      updated_raffle = Reward.find reward.id
      data["status"].should eq(205)
      data["message"].should include("Dollar value must be greater than 0")
      data["message"].should include("Quantity must be greater than 0")
      data["message"].should include("Bean cost must be greater than 0")
    end

  end

  describe "Delete Reward" do
     it "should delete reward" do
      reward = FactoryGirl.create(:reward, merchant: merchant)
      delete :destroy, id: reward.id
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(200)
      data["message"].should eq("deleted reward successfully.")
    end

    it "should return error when user not signed in yet" do
      sign_out merchant
      reward = FactoryGirl.create(:reward, merchant: merchant)
      delete :destroy, id: reward.id, format: :json
      response.should_not be_success
      data = JSON.parse(response.body)
      puts data.inspect
      data["error"].should eq("You need to sign in or sign up before continuing.")
    end

    it "should return error when input wrong reward id" do
      id = -11
      delete :destroy, id: id, format: :json
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("coundn't found reward with id #{id}.")
    end
    
  end


end
