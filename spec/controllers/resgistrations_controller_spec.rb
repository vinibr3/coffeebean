require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  context 'GET new' do
    before { get :new, params: { locale: :en } }

    it { is_expected.to(route(:get, '/en/registrations/new').to(action: :new, locale: :en)) }
    it { is_expected.to(render_template(:new)) }
    it { is_expected.to(render_with_layout(:application)) }
    it { is_expected.to(respond_with(:ok)) }
  end

  context 'POST create' do
    let(:user) { attributes_for(:user) }
    let(:params) { {name: user[:name], email: 'teste@teste.com', password: '12!@qwQWasAS', password_confirmation: '12!@qwQWasAS'} }

    it { is_expected.to(route(:post, '/en/registrations').to(action: :create, locale: :en)) }

    context 'with valid params' do
      before { post :create, params: { user: params, locale: :en } }

      it { is_expected.to(redirect_to(new_session_path)) }
      it { is_expected.to(respond_with(:found)) }
    end

    context 'with invalid params' do
      let(:params) { { name: '', email: '', password: '', password_confirmation: '' } }
      before { post :create, params: { user: params, locale: :en } }

      it { is_expected.to(render_template(:new)) }
      it { is_expected.to(respond_with(:unprocessable_entity)) }
    end
  end
end
