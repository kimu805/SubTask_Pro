class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    gon.public_key = ENV["STRIPE_TEST_PUBLISHABLE_KEY"]
    @price_id = ENV["STRIPE_TEST_PRICE_ID"]
  end

  def create
    price_id = ENV["STRIPE_TEST_PRICE_ID"]
    customer = Stripe::Customer.create(
      email: current_user.email,
      payment_method: params[:payment_method_id],
      invoice_settings: { default_payment_method: params[:payment_method_id] }
    )
    puts params.inspect()
    subscription = Stripe::Subscription.create(
      customer: customer.id,
      items: [ { price: price_id } ],
      payment_settings: { payment_method_types: [ "card" ] }
    )
    puts subscription.inspect()
    Subscription.create!(
      user_id: current_user.id,
      stripe_subscription_id: subscription.id,
      status: subscription["status"],
      started_at: Date.today
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
