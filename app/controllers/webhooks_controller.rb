class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    event = nil

    begin
      event = Stripe::Event.construct_from(JSON.parse(payload))
    rescue JSON::ParserError => e
      render json: { message: "Invalid payload" }, status: 400
      return
    end

    case event.type
    when "invoice.payment_succeeded"
      handle_payment_success(event.data.object)
    when "customer.subscription.deleted"
      handle_subscription_cancellation(event.data.object)
    end

    render json: { message: "Success" }, status: 200
  end

  private

  def handle_payment_success(invoice)
    redirect_to root_path, notice: "支払が成功しました。"
  end

  def handle_subscription_cancellation(subscription)
    redirect_to root_path, notice: "サブスクリプションをキャンセルしました。"
  end
end
