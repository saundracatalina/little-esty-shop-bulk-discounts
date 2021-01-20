class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :merchant_id,
                        :customer_id

  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:cancelled, :in_progress, :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_revenue_with_discount
    rev_with_disc = invoice_items.sum do |ii|
      revenue = ii.quantity * ii.unit_price
      discount = ii.find_best_discount
      if discount
        revenue * (1-(discount.percent_discount/100))
      else
        revenue
      end
    end
  end
end
