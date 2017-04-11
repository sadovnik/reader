require 'rails_helper'
require 'user_helper'
require 'fakeweb_helper'
require 'fixture'

fixture = Fixture.new(File.expand_path(__FILE__))

describe SubscriptionsController do
  describe 'POST /subscriptions' do
    before(:all) do
      Feedjira.logger = Rails.logger
      FakeWeb.allow_net_connect = false
    end
    after(:all) { FakeWeb.allow_net_connect = true }

    context 'not authorized user' do
      it 'redirects to the root' do
        post :create, params: { subscription_form: { url: feed_path } }

        expect(response).to redirect_to(root_path)
      end
    end

    context 'authorized user' do
      let(:user) { User.create!({ email: 'fergus.miller@example.com' }) }
      let(:params) { { subscription_form: { url: link } } }

      before { login(user) }

      context 'unvalid params' do
        it 'renders new action' do
          post :create, params: { subscription_form: { url: '' } }

          expect(response).to render_template(:new)
        end
      end

      context 'direct link to feed' do
        let(:link) { 'http://daringfireball.net/feeds/main' }

        before do
          fake link, with: fixture.get('daringfireball.net.main-feed.xml'), as: 'text/xml; charset=UTF8'
        end

        it 'subscribes user to the source' do
          post :create, params: params

          expect(user.subscriptions.count).to eq(1)
        end

        it 'redirects to /subscriptions' do
          post :create, params: params

          expect(response).to redirect_to('/subscriptions')
        end

        context 'user already subscribed to the source' do
          it "doesn't subscribes" do
            expect { 2.times { post :create, params: params } }.to \
              change { user.subscriptions.count }.by(1)
          end

          it 'responses with validation error' do
            2.times { post :create, params: params }

            expect(response).to have_http_status(422)
            expect(response).to render_template(:new)
          end
        end

        context 'unknown source' do
          it 'downloads feed and converts it into source' do
            expect { post :create, params: params }.to change { Source.count }.by(1)
          end
        end

        context 'known source' do
          before { Source.create!(title: 'Daring Fireball', url: link) }

          it 'takes the source from database' do
            expect { post :create, params: params }.not_to change { Source.count }
          end
        end
      end

      context 'link to a site containing feed' do
        let(:link) { 'https://www.joelonsoftware.com' }

        before do
          fake link, with: fixture.get('www.joelonsoftware.com.html'), as: 'text/html; charset=UTF8'
          fake link + '/feed/', with: fixture.get('www.joelonsoftware.com.feed.xml'), as: 'text/xml; charset=UTF8'
        end

        context 'user already subscribed to the source' do
          it "doesn't subscribes" do
            expect { 2.times { post :create, params: params } }.to \
              change { user.subscriptions.count }.by(1)
          end

          it 'responses with validation error' do
            2.times { post :create, params: params }

            expect(response).to have_http_status(422)
            expect(response).to render_template(:new)
          end
        end
      end

      context 'link to a site with no feed' do
        let(:link) { 'https://en.hexlet.io' }

        before do
          fake link, with: fixture.get('en.hexlet.io.html'), as: 'text/html; charset=UTF8'
        end

        it 'responses with validation error' do
          post :create, params: params

          expect(response).to have_http_status(422)
          expect(response).to render_template(:new)
        end

        it "doesn't subscribes user" do
          expect { post :create, params: params }.not_to \
            change { user.subscriptions.count }
        end
      end
    end
  end
end
