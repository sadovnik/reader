describe SessionsController do
  context 'with logged user' do
    let(:user) { User.create({ email: 'fergus.miller@example.com' }) }

    it 'logs user out and redirects to ' do
      session[:user_id] = user.id

      post :destroy

      expect(session[:user_id]).to be_nil
    end
  end

  context 'without logged user' do
    it 'redirects to the root page' do
      post :destroy

      expect(response).to redirect_to root_path
    end
  end
end
