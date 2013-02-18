class Merchant::PrizesController < Merchant::BaseController
  
  def new_prize
   render :layout=>"merchant_ajax_call"
  end

  def create_prize
    render :layout=>"merchant_ajax_call"

  end
 
end
