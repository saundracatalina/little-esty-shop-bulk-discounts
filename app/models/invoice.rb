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
      x = ii.quantity * ii.unit_price
      y = ii.find_best_discount
      if y
        x * (1-(y.percent_discount/100))
      else
        x
      end
    end
  end


  # y = merchant.bulk_discounts.where("bulk_discounts.quantity <= ?", ii.quantity).order(percent_discount: :desc).first
    #
    # items.joins(merchant: :bulk_discounts).select("bulk_discounts.*")
    # .where("invoice_items.quantity >= bulk_discounts.quantity")
    # .order(percent_discount: :desc).first.percent_discount

#below query has access to unit_price and ii quantity
    # items.joins(merchant: :bulk_discounts)
    # .select("bulk_discounts.*, invoice_items.quantity, invoice_items.unit_price")
    # .where("invoice_items.quantity >= bulk_discounts.quantity")
    # .order(percent_discount: :desc).first.quantity

    # go into tables and be able to find best available discount
    # order discounts available desc to compare if the
    # quantity being purchased (on ii) is >=
    # the biggest discount threshold available for that merch
    # items.joins(:merchant).pluck(:merchant_id)
    # items.joins(merchant: :bulk_discounts).select("invoice_items.*")

    # items.joins(merchant: :bulk_discounts)
    # .select("bulk_discounts.*").where("bulk_discounts.quantity <= invoice_items.quantity")
    # .first.id

    # .first.percent_discount
    # items.joins(merchant: :bulk_discounts).select("bulk_discounts.*").where("bulk_discounts.quantity <= invoice_items.quantity").order(percent_discount: :desc).first.percent_discount
    # require "pry"; binding.pry
  # end
  # def find_invoice_item_discount
  #
  #   items.joins(merchant: :bulk_discounts).select("bulk_discounts.*").where("bulk_discounts.quantity <= invoice_items.quantity")
  #   # items.joins(merchant: :bulk_discounts).select("bulk_discounts.*").where("bulk_discounts.quantity <= invoice_items.quantity")
  #   #.first.id
  # end

  # def calc_discount
  #   # ii quantity for that specific item
  #   # who's item is it
  #   # does that merchant's discount apply or not
  #   # calculate that item's total with discount
  #   # pass that amount to total_rev above to
  #   # be summed for that invoice
  #   # pass in ii quantity and associated discount threshold
  # end
end
