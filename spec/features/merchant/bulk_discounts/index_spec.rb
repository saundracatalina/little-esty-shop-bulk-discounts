require 'rails_helper'

describe "bulk_discounts index page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @merch1_disc1 = BulkDiscount.create!(name: "Hair Care Discount 1", quantity: 10, percent_discount: 10, merchant_id: @merchant1.id)
    @merch1_disc2 = BulkDiscount.create!(name: "Hair Care Discount 2", quantity: 15, percent_discount: 20, merchant_id: @merchant1.id)

    @merch2_disc1 = BulkDiscount.create!(name: "Jewelry Discount 1", quantity: 75, percent_discount: 75, merchant_id: @merchant2.id)
  end
  it "can see all my bulk discounts, their percent_discount, and quantity thresholds" do
    visit merchant_bulk_discounts_path(@merchant1)

    within("#discount-#{@merch1_disc1.id}") do
      expect(page).to have_content(@merch1_disc1.name)
      expect(page).to have_content("You get #{@merch1_disc1.percent_discount}% off")
      expect(page).to have_content("When you buy at least #{@merch1_disc1.quantity} of the same item")
    end
    within("#discount-#{@merch1_disc2.id}") do
      expect(page).to have_content(@merch1_disc2.name)
      expect(page).to have_content("You get #{@merch1_disc2.percent_discount}% off")
      expect(page).to have_content("When you buy at least #{@merch1_disc2.quantity} of the same item")
    end
    expect(page).to_not have_content(@merch2_disc1.name)
    expect(page).to_not have_content(@merch2_disc1.quantity)
    expect(page).to_not have_content(@merch2_disc1.percent_discount)
  end
  it "has a link to the show page of each discount listed" do
    visit merchant_bulk_discounts_path(@merchant1)

    within("#discount-#{@merch1_disc1.id}") do
      click_link "Check out this discount!"
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @merch1_disc1))
    end
    visit merchant_bulk_discounts_path(@merchant1)

    within("#discount-#{@merch1_disc2.id}") do
      click_link "Check out this discount!"
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @merch1_disc2))
    end
  end
  it "has a link to create a new discount that takes you to a form" do
    visit merchant_bulk_discounts_path(@merchant1)

    click_link "Create a New Discount"

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
  end
  it "has a link next to each discount to delete it, when clicked a flash mess. appears and it's no longer on page" do
    visit merchant_bulk_discounts_path(@merchant1)

    within("#discount-#{@merch1_disc1.id}") do
      click_link "Delete this discount."
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to have_content('Discount has been deleted!')
    expect(page).to_not have_content(@merch1_disc1.name)
    expect(page).to_not have_content(@merch1_disc1.quantity)
    expect(page).to_not have_content(@merch1_disc1.percent_discount)
  end
end
