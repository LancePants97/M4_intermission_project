require 'rails_helper'

RSpec.describe "Customer Subscription Creation Request", type: :request do
  it "creates a subscription" do
    customer1 = Customer.create!(first_name: "Bob", last_name: "Bobertson", email: "Bob@builder.com", address: "1234 Road st. Denver, CO")
    customer2 = Customer.create!(first_name: "Shaggy", last_name: "MaryJane", email: "shaggy@mysteryinc.com", address: "1234 Street st. Point Pleasant, NJ")
    customer3 = Customer.create!(first_name: "Scooby", last_name: "Doo", email: "scooby@mysteryinc.com", address: "1234 Street st. Point Pleasant, NJ")

    subscription1 = Subscription.create!(tier: 0, price: 5.99, status: 1, frequency: 0)
    subscription2 = Subscription.create!(tier: 1, price: 10.99, status: 1, frequency: 0)
    subscription3 = Subscription.create!(tier: 2, price: 15.99, status: 1, frequency: 0)

    subscription4 = Subscription.create!(tier: 0, price: 5.99, status: 1, frequency: 1)
    subscription5 = Subscription.create!(tier: 1, price: 10.99, status: 1, frequency: 1)
    subscription6 = Subscription.create!(tier: 2, price: 15.99, status: 1, frequency: 1)

    CustomerSubscription.create!(customer: customer1, subscription: subscription1)
    CustomerSubscription.create!(customer: customer1, subscription: subscription3)
    CustomerSubscription.create!(customer: customer1, subscription: subscription4)
    binding.pry
  end
end