class Api::V0::CustomerSubscriptionsController < ApplicationController
  def create
    binding.pry
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address)
  end

  def subscription_params
    params.require(:user).permit(:tier, :price, :status, :frequency)
  end
end