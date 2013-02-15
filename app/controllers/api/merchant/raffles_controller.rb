class Api::Merchant::RafflesController < Api::Merchant::BaseController
  def create
    @raffle = current_merchant.raffles.create(params[:raffle])
#    puts params[:raffle].inspect
#    puts @raffle.errors.inspect
#    puts @raffle.prize.inspect
    if @raffle.errors.blank?
      render json: {status: 200, raffle: @raffle.attributes}
    else
      render json: {status: 205, message: @raffle.errors.full_messages}
    end
  end
  
  def destroy
    @raffle = Raffle.where(id: params[:id]).first
    if @raffle
      @raffle.destroy
      render json: {status: 200, message: "deleted raffle successfully."}
    else
      render json: {status: 205, message: "coundn't find raffle with id #{params[:id]}."}
    end
  end
  
  def update
    @raffle = Raffle.where(id: params[:id]).first
    if @raffle
      if @raffle.update_attributes(params[:raffle])
        render json: {status: 200, message: "updated raffle successfully."}
      else
        render json: {status: 205, message: @raffle.errors.full_messages}
      end
    else
      render json: {status: 205, message: "coundn't find raffle with id #{params[:id]}."}
    end
  end
end
