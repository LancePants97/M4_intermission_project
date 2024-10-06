require 'rails_helper'

RSpec.describe CustomerSubscription, type: :model do
  describe "associations" do
    it { should belong_to(:customer)}
    it { should belong_to(:subscription)}
  end

  describe "instance methods" do
    it "unsubscribe" do
      customer2 = Customer.create!(first_name: "Shaggy", last_name: "Mystery", email: "shaggy@mysteryinc.com", address: "1234 Street st. Point Pleasant, NJ")
      subscription2 = Subscription.create!(tier: 1, price: 10.99, frequency: 0)
      customer_subscription = CustomerSubscription.create!(customer: customer2, subscription: subscription2)

      expect(customer_subscription.status).to eq("active")
      expect(customer_subscription.unsubscribe).to eq("inactive")
    end
  end
end