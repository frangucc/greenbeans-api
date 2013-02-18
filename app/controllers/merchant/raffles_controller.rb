class Merchant::RafflesController < ApplicationController


def create

  @raffle = Raffle.new(params[:raffle])
  @raffle.merchant_id=current_merchant.id
  count = params[:raffle][:num_of_winner].to_i
  @tier = {}
  (0..count-1).each do |x|
    t={}
    t["#{x+1}st prize"]=params["tire_prize#{x}"].to_i
    @tier.merge!(t)
  end
  @price = Prize.create(:p_type=>params[:prize][:p_type],:tier=>@tier)
  @raffle.prize = @price
  if @raffle.save
    flash[:notice]="Sucessfully Added"
  else
   add_error_messages_to_flash

  end
  render '/merchant/prizes/index' , :layout=>'merchant'
 end

end
