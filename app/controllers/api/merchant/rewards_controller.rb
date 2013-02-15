class Api::Merchant::RewardsController < Api::Merchant::BaseController

  def index
    @rewards = current_merchant.rewards
    render json: {status: 200, reward: @rewards}
  end

  def show
    @reward = current_merchant.rewards.find(params[:id])
    render json: {status: 200, reward: @reward.attributes}  
  end

  def create
    puts params[:reward].inspect
    @reward = current_merchant.rewards.create(params[:reward])
    if @reward.errors.blank?
      render json: {status: 200, reward: @reward.attributes}
    else
      render json: {status: 205, message: @reward.errors.full_messages}
    end
  end

  def update
    @reward = Reward.where(id: params[:id]).first  
    if @reward
      if @reward.update_attributes(params[:reward])
        render json: {status: 200, message: "updated reward successfully."}
      else
        render json: {status: 205, message: @reward.errors.full_messages}
      end
    else
      render json: {status: 205, message: "coundn't found reward with id #{params[:id]}."}
    end
  end

  def destroy
    @reward = Reward.where(id: params[:id]).first    
    if @reward
      @reward.destroy
      render json: {status: 200, message: "deleted reward successfully."}
    else
      render json: {status: 205, message: "coundn't found reward with id #{params[:id]}."}
    end
  end

end
