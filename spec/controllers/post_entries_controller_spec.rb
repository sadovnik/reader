require 'rails_helper'

describe PostEntriesController do
  describe 'PUT /feed/entries/:id/status' do
    context 'not authorized user' do
      it 'redirects to the root' do
        put :update_status, params: { id: 123 }

        expect(response).to redirect_to(root_path)
      end
    end

    context 'authorized user' do
      let!(:user) { User.create!(email: 'macie@mac-demarco.com') }

      before { login(user) }

      context 'existing entry' do
        let(:source) { Source.create!(title: 'daring fireball') }
        let(:post) { Post.create!(url: 'http://daringfireball.net/2017/03/about_that_10_point_5_inch_ipad', source: source) }
        let(:entry) { PostEntry.create!(user: user, post: post, status: :unread) }
        # TODO: seems like i need to start using factory_girl or something

        it 'marks entry as read by default' do
          put :update_status, params: { id: entry.id }
          entry.reload

          expect(entry.read?).to be_truthy
        end

        it 'updates status if :status param provided' do
          put :update_status, params: { id: entry.id, status: 'read' }
          entry.reload

          expect(entry.read?).to be_truthy

          put :update_status, params: { id: entry.id, status: 'unread' }
          entry.reload

          expect(entry.unread?).to be_truthy
        end

        it 'redirects to /feed' do
          put :update_status, params: { id: entry.id }

          expect(response).to redirect_to(feed_path)
        end
      end

      context 'not existing entry' do
        it 'returns 404' do
          expect { put :update_status, params: { id: 123 } }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
