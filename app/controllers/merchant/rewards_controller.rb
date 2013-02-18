class Merchant::RewardsController < ApplicationController
 def index
    @rewards = current_merchant.rewards

  end

  def show
    @reward = current_merchant.rewards.find(params[:id])

  end

  def create
    @reward = current_merchant.rewards.create(params[:reward])

  end

  def update
    @reward = Reward.where(id: params[:id]).first
    if @reward
      if @reward.update_attributes(params[:reward])
        render :text=>"updated reward successfully."
      end
    end
  end

  def destroy
    @reward = Reward.where(id: params[:id]).first
    if @reward
      @reward.destroy
      render :text=> "deleted reward successfully."
    else
      render :text=> "coundn't found reward with id #{params[:id]}."
    end
  end


end
