require 'rails_helper'

describe PostEntriesController do
  describe 'GET /post_entries/:id/read' do
    context 'not authorized user' do
      it 'redirects to the root' do
        get :read, params: { id: 123 }

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

        it 'marks entry as read' do
          get :read, params: { id: entry.id }
          entry.reload

          expect(entry.read?).to be_truthy
        end

        it 'redirects to the target url' do
          get :read, params: { id: entry.id }

          expect(response).to redirect_to(entry.post.url)
        end
      end

      context 'not existing entry' do
        it 'returns 404' do
          expect { get :read, params: { id: 123 } }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
