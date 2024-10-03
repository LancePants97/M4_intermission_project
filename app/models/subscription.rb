class Subscription < ApplicationRecord
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions

  validates :tier, presence: true
  validates :price, presence: true
  validates :frequency, presence: true

  enum tier: { bronze: 0, silver: 1, gold: 2 }
  enum frequency: {  weekly: 0, monthly: 1 }
end