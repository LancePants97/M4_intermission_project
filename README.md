# M4 INTERMISSION PROJECT README

HOW TO CLONE REPO
- In terminal, run: "git clone git@github.com:LancePants97/M4_intermission_project.git"
- In terminal, run: "bundle install"
- In terminal, run: "rails db:{drop,create,migrate}"

RUN ALL TESTS
- In terminal: run: "bundle exec rspec"
- In terminal: run: "open coverage/index.html"

--- ENDPOINTS ---

ENDPOINT 1: Subscribe a customer to a tea subscription
- GET /api/v0/customer_subscriptions
- Must include customer and subscriber attributes in body for a response. Examples below
Body: 
{ 
  customer: 
    { 
      "id": customer.id,
      "first_name": "Shaggy",
      "last_name": "Mystery",
      "email": "shaggy@mysteryinc.com",
      "address": "1234 Street st. Point Pleasant, NJ"
    },
  subscription:
    {
      "id": subscription.id,
      "tier": 1,
      "price": 10.99,
      "frequency": 0
    }
}

Response: 
{
  :type=>"customer_subscription",
  :id=>199,
  :attributes=> {
    :customer=> {
      :customer_id=>384, 
      :first_name=>"Shaggy", 
      :last_name=>"Mystery", 
      :email=>"shaggy@mysteryinc.com", 
      :address=>"1234 Street st. Point Pleasant, NJ"
    },
    :subscription=> {
      :tier=>"silver", 
      :price=>10.99, 
      :frequency=>"weekly", 
      :subscription_date=>"2024-10-06 20:40:31 UTC"
    }
  }
}

ENDPOINT 2: Cancel a Customer's Subscription
- PATCH "/api/v0/customer_subscriptions/#{customer_subscription.id}"
- Must include customer_subscription attributes in body for a response. Examples below
Body:
{
  "customer_id": customer.id,
  "subscription_id": subscription.id,
  "status": "inactive"
}
# NOTE: Even though the subscription's status is active, you must pass "inactive" as the status in the body from the front end in order for the subscription to properly deactivate

Response:
{
  :status=>"inactive", 
  :customer_id=>426, 
  :subscription_id=>828, 
  :id=>220, 
  :created_at=>"2024-10-06T20:52:36.558Z", 
  :updated_at=>"2024-10-06T20:52:36.570Z"
}

ENDPOINT 3: See all of a customer's subscriptions
- GET "/api/v0/customer_subscriptions/#{customer.id}"
- Must include customer id in the url path for a response. Examples below
The customer in this example has 3 subscriptions in the database.
Response:
{
  :type=>"customer_subscriptions",
  :customer_id=>429,
  :attributes=> {
    :customer=> {
      :first_name=>"Shaggy", 
      :last_name=>"Mystery", 
      :email=>"shaggy@mysteryinc.com", 
      :address=>"1234 Street st. Point Pleasant, NJ"
    },
    :subscriptions=> [
      {
        :subscription_id=>833, 
        :tier=>"bronze", 
        :price=>5.99, :frequency=>"weekly"
      },
      {
        :subscription_id=>834, 
        :tier=>"silver", 
        :price=>10.99, 
        :frequency=>"weekly"
      },
     {
      :subscription_id=>835, 
      :tier=>"gold", 
      :price=>15.99, 
      :frequency=>"weekly"
      }
    ]
  }
}