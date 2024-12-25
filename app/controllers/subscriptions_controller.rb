class SubscriptionsController < ApplicationController
  def new
    @price_id = ENV["STRIPE_TEST_PRICE_ID"]
  end

  def create
    customer = Stripe::Customer.create(email: current_user.email, source: params[:stripeToken])
    subscription = Stripe::Subscription.create({
      customer: customer.id,
      items: [ { price: params[:price_id] } ]
    })
    current_user.subscription.create(
      stripe_subscription_id: subscription.id,
      status: subscription.status
    )
    redirect_to root_path, notice: "サブスクリプションを開始しました"
  end

  def destroy
    subscription = Stripe::Subscription.retrieve(current_user.subscription.stripe_subscription_id)
    subscription.cancel_at_period_end = true
    subscription.save

    current_user.subscription.update(status: "canceled")
    redirect_to root_path, notice: "サブスクリプションを取消しました"
  end
end
