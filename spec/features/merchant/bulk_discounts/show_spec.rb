require 'rails_helper'

describe "bulk_discount's show page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @merch1_disc1 = BulkDiscount.create!(name: "Hair Care Discount 1", quantity: 10, percent_discount: 10, merchant_id: @merchant1.id)
    @merch1_disc2 = BulkDiscount.create!(name: "Hair Care Discount 2", quantity: 15, percent_discount: 20, merchant_id: @merchant1.id)

    @merch2_disc1 = BulkDiscount.create!(name: "Jewelry Discount 1", quantity: 75, percent_discount: 75, merchant_id: @merchant2.id)
  end
  it "can see the bulk discount's name, quantity threshold and percent_discount" do
    visit merchant_bulk_discount_path(@merchant1, @merch1_disc1)

    expect(page).to have_content(@merch1_disc1.name)
    expect(page).to have_content(@merch1_disc1.percent_discount)
    expect(page).to have_content(@merch1_disc1.quantity)

    expect(page).to_not have_content(@merch1_disc2.name)
    expect(page).to_not have_content(@merch1_disc2.percent_discount)
    expect(page).to_not have_content(@merch1_disc2.quantity)

    expect(page).to_not have_content(@merch2_disc1.name)
    expect(page).to_not have_content(@merch2_disc1.percent_discount)
    expect(page).to_not have_content(@merch2_disc1.quantity)
  end
  it "has a link to edit that discount that takes you to an edit page" do
    visit merchant_bulk_discount_path(@merchant1, @merch1_disc1)

    click_link "Edit this discount"

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @merch1_disc1))
  end
end
