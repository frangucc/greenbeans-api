require 'spec_helper'

describe Api::Merchant::RafflesController do
  render_views

  let!(:merchant) { FactoryGirl.create(:merchant) }

  before do
    sign_in merchant
  end
  describe "Create" do

    it "should create raffle" do
      post :create, raffle: {name: "Test Raffle", num_of_winner: 3}
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(200)
      data["raffle"]["name"].should eq("Test Raffle")
    end

    it "should return error when user not signed in yet" do
      sign_out merchant
      post :create, format: :json
      response.should_not be_success
      data = JSON.parse(response.body)
      data["error"].should eq("You need to sign in or sign up before continuing.")
    end

    it "should not create raffle when missing name" do
      post :create, raffle: {num_of_winner: 3}
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("Name can't be blank")
    end

    it "should not create raffle when missing num of winner" do
      post :create, raffle: {name: "Test Raffle"}
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("Num of winner can't be blank")
    end

    it "should not create raffle when num of winner is not a number" do
      post :create, raffle: {name: "Test Raffle", num_of_winner: "invalid"}
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("Num of winner is not a number")
    end

    it "should not create raffle if drawing time is less than or equal to 5 mins from current time" do
      draw_time = Time.now + 300
      post :create, raffle: {name: "Test Raffle", num_of_winner: 1, prize_attributes: {p_type: "money", tier: {first: 1}}, drawing_time: draw_time}
      response.should be_success
      data = JSON.parse(response.body)
      puts data.inspect
      data["status"].should eq(205)
      data["message"].should include("Drawing time should be atleast 5 mins ahead of current time")
    end

     it "should not create raffle if drawing time has invalid format" do
      #draw_time = Time.now + 10**2
      post :create, raffle: {name: "Test Raffle", num_of_winner: 1, prize_attributes: {p_type: "money", tier: {first: 1}}, drawing_time: "2013-22-13 07:00:08"}
      response.should be_success
      data = JSON.parse(response.body)
      puts data.inspect
      data["status"].should eq(205)
      data["message"].should include("Drawing time Format should be in 'yyyy-mm-dd hh:mm:ss'")
    end

    it "should not create raffle if drawing time is less 5 mins from current time" do
      draw_time = Time.now - 1200
      post :create, raffle: {name: "Test Raffle", num_of_winner: 1, prize_attributes: {p_type: "money", tier: {first: 1}}, drawing_time: draw_time}
      response.should be_success
      data = JSON.parse(response.body)
      puts data.inspect
      data["status"].should eq(205)
      data["message"].should include("Drawing time should be atleast 5 mins ahead of current time")
    end

    describe "Prize" do
      it "should not create raffle with invalid prize type" do
        post :create, raffle: {name: "Test Raffle", num_of_winner: 3, prize_attributes: {p_type: "invalid"}}
        response.should be_success
        data = JSON.parse(response.body)
        data["status"].should eq(205)
        data["message"].should include("Prize p type is not included in the list")
      end

      it "should create raffle with valid prize type" do
        post :create, raffle: {name: "Test Raffle", num_of_winner: 3, prize_attributes: {p_type: Prize::TYPE.first}}
        response.should be_success
        data = JSON.parse(response.body)
        data["status"].should eq(200)
        data["raffle"]["name"].should eq("Test Raffle")
      end
    end
  end

  describe "Delete" do
    it "should delete raffle" do
      raffle = FactoryGirl.create(:raffle, merchant: merchant)
      delete :destroy, id: raffle.id
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(200)
      data["message"].should eq("deleted raffle successfully.")
    end

    it "should return error when user not signed in yet" do
      sign_out merchant
      raffle = FactoryGirl.create(:raffle, merchant: merchant)
      delete :destroy, id: raffle.id, format: :json
      response.should_not be_success
      data = JSON.parse(response.body)
      data["error"].should eq("You need to sign in or sign up before continuing.")
    end

    it "should return error when input wrong id" do
      delete :destroy, id: -1, format: :json
      response.should be_success
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("coundn't found raffle with id -1.")
    end

  end

  describe "Update" do
    it "should update raffle" do
      raffle = FactoryGirl.create(:raffle, merchant: merchant)
      raffle_hash = {name: "New Name", num_of_winner: 1}
      put :update, id: raffle.id, raffle: raffle_hash
      data = JSON.parse(response.body)
      data["status"].should eq(200)
      updated_raffle = Raffle.find raffle.id
      updated_raffle.name.should eq "New Name"
      updated_raffle.num_of_winner.should eq 1
    end

    it "should return error when user not signed in yet" do
      sign_out merchant
      raffle = FactoryGirl.create(:raffle, merchant: merchant)
      raffle_hash = {name: "New Name", num_of_winner: 1}
      put :update, id: raffle.id, raffle: raffle_hash, format: :json
      response.should_not be_success
      data = JSON.parse(response.body)
      data["error"].should eq("You need to sign in or sign up before continuing.")
    end

    it "should not update with blank name" do
      raffle = FactoryGirl.create(:raffle, merchant: merchant)
      raffle_hash = {name: "", num_of_winner: 1}
      put :update, id: raffle.id, raffle: raffle_hash
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("Name can't be blank")
      updated_raffle = Raffle.find raffle.id
      updated_raffle.name.should eq raffle.name
    end

    it "should not update with blank num_of_winner" do
      raffle = FactoryGirl.create(:raffle, merchant: merchant)
      raffle_hash = {name: "New Name", num_of_winner: ''}
      put :update, id: raffle.id, raffle: raffle_hash
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("Num of winner can't be blank")
      updated_raffle = Raffle.find raffle.id
      updated_raffle.name.should eq raffle.name
    end

    it "should not update when num_of_winner is not a number" do
      raffle = FactoryGirl.create(:raffle, merchant: merchant)
      raffle_hash = {name: "New Name", num_of_winner: "invalid"}
      put :update, id: raffle.id, raffle: raffle_hash
      data = JSON.parse(response.body)
      data["status"].should eq(205)
      data["message"].should include("Num of winner is not a number")
      updated_raffle = Raffle.find raffle.id
      updated_raffle.name.should eq raffle.name
    end

    describe "Prize" do
      it "should not update raffle with invalid prize type" do
        raffle = FactoryGirl.create(:raffle, merchant: merchant)
        raffle_hash = {name: "New Name", num_of_winner: 1, prize_attributes: {p_type: "invalid"}}
        put :update, id: raffle.id, raffle: raffle_hash
        response.should be_success
        data = JSON.parse(response.body)
        data["status"].should eq(205)
        data["message"].should include("Prize p type is not included in the list")
      end

      it "should create raffle with valid prize type" do
        raffle = FactoryGirl.create(:raffle, merchant: merchant)
        raffle_hash = {name: "New Name", num_of_winner: 1, prize_attributes: {p_type: Prize::TYPE.last}}
        put :update, id: raffle.id, raffle: raffle_hash
        response.should be_success
        data = JSON.parse(response.body)
        data["status"].should eq(200)
        assigns["raffle"].name.should eq("New Name")
        assigns["raffle"].prize.p_type.should eq Prize::TYPE.last
      end

      it "should create raffle with prizes" do
        post :create, raffle: {name: "Test Raffle", num_of_winner: 3, drawing_time: @draw_time, prize_attributes: {p_type: "money", tier: {first: 1, second:2,third:3}}}
        response.should be_success
        data = JSON.parse(response.body)
        puts data.inspect
        data["status"].should eq(200)
        data["raffle"]["name"].should eq("Test Raffle")
      end

      it "should not create raffle if there are no prizes" do
        post :create, raffle: {name: "Test Raffle", num_of_winner: 3, drawing_time: @draw_time}
        response.should be_success
        data = JSON.parse(response.body)
        puts data.inspect
        data["status"].should eq(205)
        data["message"].should include("Prize can't be blank")
      end

      it "should not create raffle if number of winners donot match number of prizes" do
        post :create, raffle: {name: "Test Raffle", num_of_winner: 3, drawing_time: @draw_time, prize_attributes: {p_type: "money"}}
        response.should be_success
        data = JSON.parse(response.body)
        puts data.inspect
        data["status"].should eq(205)
        data["message"].should include("Prize Number and winners number donot match")
      end

      it "should create raffle when number of winners is equal to number of prizes" do
        draw_time = Time.now + 500
        post :create, raffle: {name: "Test Raffle", num_of_winner: 1, prize_attributes: {p_type: "money", tier: {first: 1}}, drawing_time: @draw_time}
        response.should be_success
        data = JSON.parse(response.body)
        puts data.inspect
        data["status"].should eq(200)
        data["raffle"]["name"].should eq("Test Raffle")
      end

      it "should not create raffle if prize type is money and its value is not a number" do
        draw_time = Time.now + 1200
        post :create, raffle: {name: "Test Raffle", num_of_winner: 1, prize_attributes: {p_type: "money", tier: {first: "23asf4"}}, drawing_time: draw_time}
        response.should be_success
        data = JSON.parse(response.body)
        puts data.inspect
        data["status"].should eq(205)
        data["message"].should include("Prize tier should be an number")
      end
    end

  end
end
