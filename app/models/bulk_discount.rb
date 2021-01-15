class BulkDiscount < ApplicationRecord
  validates_presence_of :quantity
  validates_presence_of :percent_discount

end
