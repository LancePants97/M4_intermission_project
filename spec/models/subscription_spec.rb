require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "associations" do
    it { should have_many(:customer_subscriptions)}
  end
end