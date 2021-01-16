class Merchant::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = Merchant.find(params[:merchant_id]).bulk_discounts
  end

end
