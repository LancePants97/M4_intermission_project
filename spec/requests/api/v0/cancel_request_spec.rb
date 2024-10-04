require 'rails_helper'

RSpec.describe "Customer Subscription Creation Request", type: :request do
  before(:each) do
  # CREATE SOME CUSTOMERS
    @customer1 = Customer.create!(first_name: "Bob", last_name: "Bobertson", email: "Bob@builder.com", address: "1234 Road st. Denver, CO")
    @customer2 = Customer.create!(first_name: "Shaggy", last_name: "Mystery", email: "shaggy@mysteryinc.com", address: "1234 Street st. Point Pleasant, NJ")
    @customer3 = Customer.create!(first_name: "Scooby", last_name: "Doo", email: "scooby@mysteryinc.com", address: "1234 Street st. Point Pleasant, NJ")

  # CREATE ALL POSSIBLE SUBSCRIPTION OPTIONS
    @subscription1 = Subscription.create!(tier: 0, price: 5.99, frequency: 0)
    @subscription2 = Subscription.create!(tier: 1, price: 10.99, frequency: 0)
    @subscription3 = Subscription.create!(tier: 2, price: 15.99, frequency: 0)

    @subscription4 = Subscription.create!(tier: 0, price: 5.99, frequency: 1)
    @subscription5 = Subscription.create!(tier: 1, price: 10.99, frequency: 1)
    @subscription6 = Subscription.create!(tier: 2, price: 15.99, frequency: 1)
  
  # CREATE A SUBSCRIPTION FOR A CUSTOMER
  end

  it "can cancel a customer's subscription" do
    customer_subscription = CustomerSubscription.create!(customer: @customer2, subscription: @subscription2)
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {
      "customer_id": @customer2.id,
      "subscription_id": @subscription2.id,
      "status": "inactive"
    }
    expect(customer_subscription.status).to eq("active")

    patch "/api/v0/customer_subscriptions/#{customer_subscription.id}", headers: headers, params: JSON.generate({ customer_subscription: body })
    
    updated_sub = CustomerSubscription.find_by(id: customer_subscription.id)
    expect(response).to be_successful

    expect(updated_sub.status).to eq("inactive")
    json = JSON.parse(response.body, symbolize_names: true)
    # binding.pry
  end
end