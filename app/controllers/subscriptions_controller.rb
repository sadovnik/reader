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

    @subscription_form = SubscriptionForm.new(current_user, url)

    unless @subscription_form.valid?
      return respond_to do |format|
        format.js
        format.html { render action: :new }
      end
    end

    source = SourceFetcher.fetch(url)

    current_user.subscribe(source)

    respond_to do |format|
      format.html { redirect_to subscriptions_path, flash: { notice: 'Successfully subscribed!' } }
    end
  end

  private

  def form_params
    params.require(:subscription_form).permit(:url)
  end
end
