class CustomerSubscriptionSerializer
  def self.subscribe_json(cus, sub, cus_sub)
    {
      "data": {
        "type": "customer_subscription",
        "id": cus_sub.id,
        "attributes": {
          "customer": {
            "customer_id": cus.id,
            "first_name": cus.first_name,
            "last_name": cus.last_name,
            "email": cus.email,
            "address": cus.address
          },
          "subscription": {
            "tier": sub.tier,
            "price": sub.price,
            "frequency": sub.frequency,
            "subscription_date": cus_sub.created_at.to_s
          }
        }
      }
    }
  end

  def self.all_subscriptions_json(cus, subs)
    {
      "data": {
        "type": "customer_subscriptions",
        "customer_id": cus.id,
        "attributes": {
          "customer": {
            "first_name": cus.first_name,
            "last_name": cus.last_name,
            "email": cus.email,
            "address": cus.address
          },
          "subscriptions": subs.map do |sub|
            {
              "subscription_id": sub.id,
              "tier": sub.tier,
              "price": sub.price,
              "frequency": sub.frequency
            }
          end
        }
      }
    }
  end
end