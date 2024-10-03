class Subscription < ApplicationRecord
  has_many :customer_subscriptions
end