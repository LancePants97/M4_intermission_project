class Api::V0::CustomerSubscriptionsController < ApplicationController
  def create
    begin
      customer = Customer.find(params[:customer][:id])
      subscription = Subscription.find(params[:subscription][:id])
      customer_sub = CustomerSubscription.new(customer_id: customer.id, subscription_id: subscription.id)
    rescue ActiveRecord::RecordNotFound => exception
      render json: { "errors": "Could Not Find User/Subscription" }, status: 400
    end

    if customer_sub.save
      render json: CustomerSubscriptionSerializer.subscribe_json(customer, subscription, customer_sub), status: 201
    else
      customer_sub.status = 0
      render json: { "errors": "Could Not Create Subscription" }, status: 400
    end
  end
end