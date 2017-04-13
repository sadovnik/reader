require 'caching_client'

class SubscriptionsController < ApplicationController
  before_action :authorize!

  # GET /subscriptions
  def index
    @subscriptions = current_user.subscriptions
  end

  # GET /subscriptions/new
  def new
    @subscription_form = SubscriptionForm.new(current_user)
  end

  # POST /subscriptions
  def create
    url = form_params[:url]

    client = CachingClient.new

    @subscription_form = SubscriptionForm.new(current_user, url, client)

    unless @subscription_form.valid?
      return respond_to do |format|
        format.js
        format.html { render action: :new, status: 422 }
      end
    end

    source = SourceFetcher.new(client).fetch(url)

    current_user.subscribe(source)

    respond_to do |format|
      format.html { redirect_to subscriptions_path, flash: { notice: 'Successfully subscribed' } }
    end
  end

  # DELETE /subscriptions/:id
  def destroy
    @subscription = Subscription.find(id_param)

    return head :forbidden if @subscription.user != current_user

    current_user.unsubscribe(@subscription.source)

    respond_to do |format|
      format.js
      format.html { redirect_to subscriptions_path, flash: { notice: 'Successfully deleted' } }
    end
  end

  private

  def id_param
    params.require(:id)
  end

  def form_params
    params.require(:subscription_form).permit(:url)
  end
end
