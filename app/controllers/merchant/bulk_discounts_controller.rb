class Merchant::BulkDiscountsController < ApplicationController
  before_action :find_discount, only: [:show]
  before_action :find_merchant, only: [:index, :new, :create]

  def index
    @discounts = @merchant.bulk_discounts
  end

  def show

  end

  def new

  end

  def create
    BulkDiscount.create!(discount_params)
    flash.notice = 'Discount has been created!'
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_discount
    @discount = BulkDiscount.find(params[:id])
  end

  def discount_params
    params.permit(:name, :quantity, :percent_discount, :merchant_id)
  end
end
