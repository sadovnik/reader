require 'rails_helper'

describe InvitesController do
  describe 'GET invites/new' do
    it 'renders template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET invites/bummer' do
    it 'renders template' do
      get :bummer
      expect(response).to render_template(:bummer)
    end
  end

  describe 'POST invites' do
    context 'with valid params' do
      let(:form) { { invite: { email: 'fergus.miller@example.com' } } }

      it 'creates invite and sends it' do
        expect { post :create, params: form }.to \
          change { Invite.count }.by(1).and \
          change { ActionMailer::Base.deliveries.count }.by(1)

        expect(response).to redirect_to invites_done_path
      end

      it 'redirects to `bummer` page if there alrady invite' do
        expect { post :create, params: form }.to \
          change { Invite.count }.by(1).and \
          change { ActionMailer::Base.deliveries.count }.by(1)

        expect { post :create, params: form }.not_to change { Invite.count }

        expect(response).to redirect_to invites_bummer_path
      end
    end
  end

  describe 'POST invites/:key/use' do
    let!(:invite) { Invite.create({ email: 'fergus.miller@example.com' }) }

    context 'any' do
      it 'marks invite as used' do
        get :use, params: { key: invite.key }

        invite.reload

        expect(invite.state).to eq(Invite::States::USED)
      end

      it 'redirects to `feed_path`' do
        get :use, params: { key: invite.key }

        expect(response).to redirect_to feed_path
      end
    end

    context 'new user' do
      it 'creates new user' do
        expect {
          get :use, params: { key: invite.key }
        }.to change { User.count }.by(1)
      end

      it 'logs in newly created user' do
        get :use, params: { key: invite.key }

        expect(session[:user_id]).to eq(User.last.id)
      end
    end

    context 'existing user' do
      let!(:user) { User.create({ email: 'fergus.miller@example.com' }) }

      it 'logs in existing user' do
        get :use, params: { key: invite.key }

        expect(session[:user_id]).to eq(user.id)
      end
    end

    context 'already used invite' do
      it 'returns 409' do
        invite.use!

        get :use, params: { key: invite.key }

        expect(response).to have_http_status(409)
      end
    end

    context 'non-existing invite' do
      it 'returns 404' do
        get :use, params: { key: 'weird-key' }

        expect(response).to have_http_status(404)
      end
    end
  end
end
