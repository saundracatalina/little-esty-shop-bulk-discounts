require 'rails_helper'

describe "bulk_discount's new page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @merch1_disc1 = BulkDiscount.create!(name: "Hair Care Discount 1", quantity: 10, percent_discount: 10, merchant_id: @merchant1.id)
    @merch1_disc2 = BulkDiscount.create!(name: "Hair Care Discount 2", quantity: 15, percent_discount: 20, merchant_id: @merchant1.id)

    @merch2_disc1 = BulkDiscount.create!(name: "Jewelry Discount 1", quantity: 75, percent_discount: 75, merchant_id: @merchant2.id)
  end
  it "can see a form to add a discount, fill it in, and get redirected to discount index" do
    visit new_merchant_bulk_discount_path(@merchant1)

    fill_in "name", with: "Hair Care Discount 3"
    fill_in "quantity", with: 25
    fill_in "percent_discount", with: 25

    click_on "Add New Discount"

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

    expect(page).to have_content('Discount has been created!')
    expect(page).to have_content("Hair Care Discount 3")
    expect(page).to have_content("You get 25.0% off")
    expect(page).to have_content("When you buy at least 25 of the same item")
  end
end
