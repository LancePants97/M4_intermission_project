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
  
  # CREATE 3 SUBSCRIPTIONS FOR CUSTOMER2
    @customer_subscription1 = CustomerSubscription.create!(customer: @customer2, subscription: @subscription1, status: "active")
    @customer_subscription2 = CustomerSubscription.create!(customer: @customer2, subscription: @subscription2, status: "inactive")
    @customer_subscription3 = CustomerSubscription.create!(customer: @customer2, subscription: @subscription3, status: "active")
  end

  it "retrieves a json list of all of a customer's subscriptions" do
    get "/api/v0/customer_subscriptions/#{@customer2.id}"
    expect(response).to be_successful

    expect(@customer2.subscriptions.count).to eq(3)
    expect(@customer1.subscriptions.count).to eq(0)
    expect(@customer3.subscriptions.count).to eq(0)

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(json).to have_key(:type)
    expect(json[:type]).to eq("customer_subscriptions")
    
    expect(json).to have_key(:customer_id)
    expect(json[:customer_id]).to be_an(Integer)
    expect(json[:customer_id]).to eq(@customer2.id)
### ---------------------------
    attrs = json[:attributes]
    
    expect(attrs).to have_key(:customer)
    expect(attrs[:customer]).to be_a(Hash)
    expect(attrs[:customer]).to have_key(:first_name)
    expect(attrs[:customer][:first_name]).to eq(@customer2.first_name)
    expect(attrs[:customer]).to have_key(:last_name)
    expect(attrs[:customer][:last_name]).to eq(@customer2.last_name)
    expect(attrs[:customer]).to have_key(:email)
    expect(attrs[:customer][:email]).to eq(@customer2.email)
    expect(attrs[:customer]).to have_key(:address)
    expect(attrs[:customer][:address]).to eq(@customer2.address)

    expect(attrs).to have_key(:subscriptions)
    expect(attrs[:subscriptions]).to be_an(Array)
    expect(attrs[:subscriptions].length).to eq(3)
### ---------------------------
    sub1 = attrs[:subscriptions][0]
    expect(sub1).to be_a(Hash)

    expect(sub1).to have_key(:subscription_id)
    expect(sub1[:subscription_id]).to be_an(Integer)
    expect(sub1[:subscription_id]).to eq(@subscription1.id)
    expect(sub1).to have_key(:tier)
    expect(sub1[:tier]).to be_a(String)
    expect(sub1[:tier]).to eq(@subscription1.tier)
    expect(sub1).to have_key(:price)
    expect(sub1[:price]).to be_a(Float)
    expect(sub1[:price]).to eq(@subscription1.price)
    expect(sub1).to have_key(:frequency)
    expect(sub1[:frequency]).to be_a(String)
    expect(sub1[:frequency]).to eq(@subscription1.frequency)
### ---------------------------
    sub2 = attrs[:subscriptions][1]
    expect(sub2).to be_a(Hash)

    expect(sub2).to have_key(:subscription_id)
    expect(sub2[:subscription_id]).to be_an(Integer)
    expect(sub2[:subscription_id]).to eq(@subscription2.id)
    expect(sub2).to have_key(:tier)
    expect(sub2[:tier]).to be_a(String)
    expect(sub2[:tier]).to eq(@subscription2.tier)
    expect(sub2).to have_key(:price)
    expect(sub2[:price]).to be_a(Float)
    expect(sub2[:price]).to eq(@subscription2.price)
    expect(sub2).to have_key(:frequency)
    expect(sub2[:frequency]).to be_a(String)
    expect(sub2[:frequency]).to eq(@subscription2.frequency)
### ---------------------------
    sub3 = attrs[:subscriptions][2]
    expect(sub3).to be_a(Hash)

    expect(sub3).to have_key(:subscription_id)
    expect(sub3[:subscription_id]).to be_an(Integer)
    expect(sub3[:subscription_id]).to eq(@subscription3.id)

    expect(sub3).to have_key(:tier)
    expect(sub3[:tier]).to be_a(String)
    expect(sub3[:tier]).to eq(@subscription3.tier)

    expect(sub3).to have_key(:price)
    expect(sub3[:price]).to be_a(Float)
    expect(sub3[:price]).to eq(@subscription3.price)

    expect(sub3).to have_key(:frequency)
    expect(sub3[:frequency]).to be_a(String)
    expect(sub3[:frequency]).to eq(@subscription3.frequency)
  end
end