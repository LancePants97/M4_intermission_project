class Api::V0::CustomerSubscriptionsController < ApplicationController
  def create
    begin
      customer = Customer.find_by(params[:customer_params])
      subscription = Subscription.find_by(params[:subscription_params])
      customer_sub = CustomerSubscription.new(customer_id: customer.id, subscription_id: subscription.id)
    rescue ActiveRecord::RecordNotFound => exception
      render json: { "errors": "Could Not Find User/Subscription" }, status: 400
    end

    if customer_sub.save
      # binding.pry
      render json CustomerSubscriptionSerializer.subscribe_json(customer_sub), status: 200
    else
      customer_sub.status = 0
      render json: { "errors": "Could Not Create Subscription" }, status: 400
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address)
  end

  def subscription_params
    params.require(:user).permit(:tier, :price, :frequency)
  end
end