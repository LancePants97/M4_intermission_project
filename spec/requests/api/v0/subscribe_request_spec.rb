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

    @customer2_body = {
      "id": @customer2.id,
      "first_name": "Shaggy",
      "last_name": "Mystery",
      "email": "shaggy@mysteryinc.com",
      "address": "1234 Street st. Point Pleasant, NJ"
    }

    @sub2_body = {
      "id": @subscription2.id,
      "tier": 1,
      "price": 10.99,
      "frequency": 0
    }

    post "/api/v0/customer_subscriptions", params: { customer: @customer2_body, subscription: @sub2_body }
  end

  it "creates a subscription" do
    expect(response).to be_successful

    customer_subscription = CustomerSubscription.last
    expect(customer_subscription).to be_present
    expect(customer_subscription.customer_id).to be_present
    expect(customer_subscription.subscription_id).to be_present
  end

  it "returns a JSON with appropriate attributes" do
    json = JSON.parse(response.body, symbolize_names: true)[:data]
    customer_subscription = CustomerSubscription.last

    expect(json).to have_key(:type)
    expect(json[:type]).to eq("customer_subscription")

    expect(json).to have_key(:id)
    expect(json[:id]).to be_an(Integer)
    expect(json[:id]).to eq(customer_subscription.id)
### ---------------------------
    expect(json[:attributes]).to have_key(:customer)
    expect(json[:attributes][:customer]).to be_a(Hash)

    expect(json[:attributes][:customer]).to have_key(:customer_id)
    expect(json[:attributes][:customer][:customer_id]).to eq(@customer2.id)
    expect(json[:attributes][:customer][:customer_id]).to_not eq(@customer1.id)
    expect(json[:attributes][:customer][:customer_id]).to_not eq(@customer3.id)

    expect(json[:attributes][:customer]).to have_key(:first_name)
    expect(json[:attributes][:customer][:first_name]).to eq(@customer2.first_name)
    expect(json[:attributes][:customer][:first_name]).to_not eq(@customer1.first_name)
    expect(json[:attributes][:customer][:first_name]).to_not eq(@customer3.first_name)

    expect(json[:attributes][:customer]).to have_key(:last_name)
    expect(json[:attributes][:customer][:last_name]).to eq(@customer2.last_name)
    expect(json[:attributes][:customer][:last_name]).to_not eq(@customer1.last_name)
    expect(json[:attributes][:customer][:last_name]).to_not eq(@customer3.last_name)

    expect(json[:attributes][:customer]).to have_key(:email)
    expect(json[:attributes][:customer][:email]).to eq(@customer2.email)
    expect(json[:attributes][:customer][:email]).to_not eq(@customer1.email)
    expect(json[:attributes][:customer][:email]).to_not eq(@customer3.email)

    expect(json[:attributes][:customer]).to have_key(:address)
    expect(json[:attributes][:customer][:first_name]).to eq(@customer2.first_name)
    expect(json[:attributes][:customer][:first_name]).to_not eq(@customer1.first_name)
    expect(json[:attributes][:customer][:first_name]).to_not eq(@customer3.first_name)
### ---------------------------
    expect(json[:attributes]).to have_key(:subscription)
    expect(json[:attributes][:subscription]).to be_a(Hash)

    expect(json[:attributes][:subscription]).to have_key(:tier)
    expect(json[:attributes][:subscription][:tier]).to eq(@subscription2.tier)
    expect(json[:attributes][:subscription][:tier]).to_not eq(@subscription1.tier)
    expect(json[:attributes][:subscription][:tier]).to_not eq(@subscription3.tier)
    expect(json[:attributes][:subscription][:tier]).to_not eq(@subscription4.tier)
    expect(json[:attributes][:subscription][:tier]).to_not eq(@subscription6.tier)

    expect(json[:attributes][:subscription]).to have_key(:price)
    expect(json[:attributes][:subscription][:price]).to eq(@subscription2.price)
    expect(json[:attributes][:subscription][:price]).to_not eq(@subscription1.price)
    expect(json[:attributes][:subscription][:price]).to_not eq(@subscription3.price)
    expect(json[:attributes][:subscription][:price]).to_not eq(@subscription4.price)
    expect(json[:attributes][:subscription][:price]).to_not eq(@subscription6.price)

    expect(json[:attributes][:subscription]).to have_key(:frequency)
    expect(json[:attributes][:subscription][:frequency]).to eq(@subscription2.frequency)
    expect(json[:attributes][:subscription][:frequency]).to_not eq(@subscription4.frequency)
    expect(json[:attributes][:subscription][:frequency]).to_not eq(@subscription5.frequency)
    expect(json[:attributes][:subscription][:frequency]).to_not eq(@subscription6.frequency)

    expect(json[:attributes][:subscription]).to have_key(:subscription_date)
    expect(json[:attributes][:subscription][:subscription_date]).to eq(customer_subscription.created_at.to_s)
  end
end