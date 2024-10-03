require 'rails_helper'

RSpec.describe "Customer Subscription Creation Request", type: :request do
  it "creates a subscription" do
    # CREATE SOME CUSTOMERS
    customer1 = Customer.create!(first_name: "Bob", last_name: "Bobertson", email: "Bob@builder.com", address: "1234 Road st. Denver, CO")
    customer2 = Customer.create!(first_name: "Shaggy", last_name: "Mystery", email: "shaggy@mysteryinc.com", address: "1234 Street st. Point Pleasant, NJ")
    customer3 = Customer.create!(first_name: "Scooby", last_name: "Doo", email: "scooby@mysteryinc.com", address: "1234 Street st. Point Pleasant, NJ")

    # CREATE ALL POSSIBLE SUBSCRIPTION OPTIONS
    subscription1 = Subscription.create!(tier: 0, price: 5.99, frequency: 0)
    subscription2 = Subscription.create!(tier: 1, price: 10.99, frequency: 0)
    subscription3 = Subscription.create!(tier: 2, price: 15.99, frequency: 0)

    subscription4 = Subscription.create!(tier: 0, price: 5.99, frequency: 1)
    subscription5 = Subscription.create!(tier: 1, price: 10.99, frequency: 1)
    subscription6 = Subscription.create!(tier: 2, price: 15.99, frequency: 1)

    CustomerSubscription.create!(customer: customer1, subscription: subscription1)
    CustomerSubscription.create!(customer: customer1, subscription: subscription3)
    CustomerSubscription.create!(customer: customer1, subscription: subscription4)
    # binding.pry
    customer_body = {
      "first_name": "Shaggy",
      "last_name": "Mystery",
      "email": "shaggy@mysteryinc.com",
      "address": "1234 Street st. Point Pleasant, NJ"
    }

    sub_body = {
      "tier": 1,
      "price": 10.99,
      "frequency": 0
    }

    post "/api/v0/customer_subscriptions", params: { customer: customer_body, subscription: sub_body }
  end
end