require 'rails_helper'
require 'user_helper'

describe SubscriptionsController do
  describe 'POST /subscriptions' do
    context 'not authorized user' do
      it 'redirects to the root' do
        post :create, params: { subscription_form: { url: feed_path } }

        expect(response).to redirect_to(root_path)
      end
    end

    context 'authorized user' do
      let(:user) { User.create!({ email: 'fergus.miller@example.com' }) }
      let(:feed_path) { 'http://daringfireball.net/feeds/main' }
      let(:params) { { subscription_form: { url: feed_path } } }

      before { login(user) }

      before do
        Feedjira.logger = Rails.logger

        feed_xml_path = File.expand_path('./fixtures/rss-feed.xml', __dir__)
        feed_xml = File.read(feed_xml_path)

        FakeWeb.register_uri(:get, feed_path, content_type: 'text/xml;charset=UTF-8', body: feed_xml)
      end

      context 'unvalid params' do
        it 'renders new action' do
          post :create, params: { subscription_form: { url: '' } }

          expect(response).to render_template(:new)
        end
      end

      context 'direct link to feed' do
        context 'valid params' do
          it 'subscribes user to the source' do
            post :create, params: params

            expect(user.subscriptions.count).to eq(1)
          end

          it 'redirects to /subscriptions' do
            post :create, params: params

            expect(response).to redirect_to('/subscriptions')
          end
        end

        context 'unknown source' do
          it 'downloads feed and converts it into source' do
            expect { post :create, params: params }.to change { Source.count }.by(1)
          end
        end

        context 'known source' do
          before { Source.create!(title: 'Daring Fireball', url: feed_path) }

          it 'takes the source from database' do
            expect { post :create, params: params }.not_to change { Source.count }
          end
        end
      end
    end
  end
end
