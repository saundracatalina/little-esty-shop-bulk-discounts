require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end
  describe "instance methods" do
    it "find_best_discount" do
      @merchant1 = Merchant.create!(name: 'Hair Care')

      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
      @item_2 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 30, merchant_id: @merchant1.id)
      @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)

      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_1.id, status: 2)
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 2)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 15, unit_price: 30, status: 2)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 5, unit_price: 5, status: 2)

      @merch1_disc1 = BulkDiscount.create!(name: "Hair Care Discount 1", quantity: 9, percent_discount: 10, merchant_id: @merchant1.id)
      @merch1_disc2 = BulkDiscount.create!(name: "Hair Care Discount 2", quantity: 14, percent_discount: 20, merchant_id: @merchant1.id)

      expect(@ii_1.find_best_discount).to eq(@merch1_disc1)
      expect(@ii_2.find_best_discount).to eq(@merch1_disc2)
      expect(@ii_3.find_best_discount).to eq(nil)
    end
  end
end
