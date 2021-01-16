class BulkDiscount < ApplicationRecord
  validates_presence_of :quantity
  validates_presence_of :percent_discount
  validates_presence_of :merchant_id
  validates_presence_of :name

  belongs_to :merchant
end
