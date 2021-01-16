require 'rails_helper'

describe "bulk_discounts index page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @merch1_disc1 = BulkDiscount.create!(quantity: 10, percent_discount: 10, merchant_id: @merchant1.id)
    @merch1_disc2 = BulkDiscount.create!(quantity: 15, percent_discount: 20, merchant_id: @merchant1.id)

    @merch2_disc1 = BulkDiscount.create!(quantity: 75, percent_discount: 75, merchant_id: @merchant2.id)
  end

  it "can see all my bulk discounts, their percent_discount, and quantity thresholds" do
    visit merchant_bulk_discounts_path(@merchant1)

    within("#discount-#{@merch1_disc1.id}") do
      expect(page).to have_content(@merch1_disc1.quantity)
      expect(page).to have_content(@merch1_disc1.percent_discount)
    end
    within("#discount-#{@merch1_disc2.id}") do
      expect(page).to have_content(@merch1_disc2.quantity)
      expect(page).to have_content(@merch1_disc2.percent_discount)
    end
    expect(page).to_not have_content(@merch2_disc1.quantity)
    expect(page).to_not have_content(@merch2_disc1.percent_discount)
  end

end
