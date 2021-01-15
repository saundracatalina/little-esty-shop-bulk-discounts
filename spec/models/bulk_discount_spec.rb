require 'rails_helper'

describe BulkDiscount do
  describe "validations" do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :percent_discount }
  end
end
