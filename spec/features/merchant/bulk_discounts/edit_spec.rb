require 'rails_helper'

describe "bulk discount edit page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @merch1_disc1 = BulkDiscount.create!(name: "Hair Care Discount 1", quantity: 10, percent_discount: 10, merchant_id: @merchant1.id)
    @merch1_disc2 = BulkDiscount.create!(name: "Hair Care Discount 2", quantity: 15, percent_discount: 20, merchant_id: @merchant1.id)

    @merch2_disc1 = BulkDiscount.create!(name: "Jewelry Discount 1", quantity: 75, percent_discount: 75, merchant_id: @merchant2.id)
  end
  it "can see a form that has prepolulated current discount information" do
    visit edit_merchant_bulk_discount_path(@merchant1, @merch1_disc1)

    expect(find_field('Name').value).to eq(@merch1_disc1.name)
    expect(find_field('Quantity').value).to eq("#{@merch1_disc1.quantity}")
    expect(find_field('Percent discount').value).to eq("#{@merch1_disc1.percent_discount}")

    expect(find_field('Name').value).to_not eq(@merch2_disc1.name)
  end
  it "can fill in edits to form, click submit, and redirect to it's show page, see updates, and flash message" do
    visit edit_merchant_bulk_discount_path(@merchant1, @merch1_disc1)

    fill_in "Name", with: "Hair Care Mega Discount"
    fill_in "Quantity", with: 65
    fill_in "Percent discount", with: 85

    click_on "Update Discount"

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @merch1_disc1))
    expect(page).to have_content("Successfully Updated Discount!")
    expect(page).to have_content("Hair Care Mega Discount")
    expect(page).to have_content("When you buy at least 65 of the same item")
    expect(page).to have_content("You will get 85.0% off")
    expect(page).to_not have_content(@merch1_disc1.name)
  end
  it "has a flash message when things aren't filled out fully and doesn't redirect" do
    visit edit_merchant_bulk_discount_path(@merchant1, @merch1_disc1)

    fill_in "Name", with: ""
    fill_in "Quantity", with: 65
    fill_in "Percent discount", with: 85

    click_on "Update Discount"

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @merch1_disc1))
    expect(page).to have_content("All fields must be completed, try again!")
  end
end
