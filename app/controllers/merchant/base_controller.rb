class Merchant::BaseController < ApplicationController
  before_filter  :authenticate_merchant!

  layout "merchant"
end
