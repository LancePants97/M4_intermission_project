class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription

  enum status: { inactive: 0, active: 1 }

  def unsubscribe
    status = "inactive"
  end
end