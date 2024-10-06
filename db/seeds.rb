Customer.destroy_all
Subscription.destroy_all
CustomerSubscription.destroy_all

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

# CREATE 3 SUBSCRIPTIONS FOR CUSTOMER2
customer_subscription1 = CustomerSubscription.create!(customer: customer2, subscription: subscription1, status: "active")
customer_subscription2 = CustomerSubscription.create!(customer: customer2, subscription: subscription2, status: "inactive")
customer_subscription3 = CustomerSubscription.create!(customer: customer2, subscription: subscription3, status: "active")

