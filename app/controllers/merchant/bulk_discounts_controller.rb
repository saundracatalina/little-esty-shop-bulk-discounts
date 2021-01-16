class Merchant::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = Merchant.find(params[:merchant_id]).bulk_discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def new 

  end
end
