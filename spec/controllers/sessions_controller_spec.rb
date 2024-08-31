require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context 'GET new' do
    before { get :new, params: { locale: :en }}

    it { is_expected.to(route(:get, '/en/sessions/new').to(action: :new, locale: :en)) }
    it { is_expected.to(render_template(:new)) }
  end

  context 'POST create' do
    let(:attributes) { attributes_for(:user) }
    let(:user) { User.new(attributes) }
    let(:params) { { email: user.email, password: user.password } }

    it { is_expected.to(route(:post, '/en/sessions').to(action: :create, locale: :en)) }

    context 'with valid params' do
      before {
        user.save_in_cache
        post :create, params: { user: params, locale: :en }
      }

      it { is_expected.to(redirect_to(registration_path(user))) }
      it { is_expected.to(respond_with(:found)) }
    end

    context 'with invalid params' do
      let(:params) { { email: Faker::Internet.email, password: '' } }
      before { post :create, params: { user: params, locale: :en } }

      it { is_expected.to(render_template(:new)) }
      it { is_expected.to(respond_with(:unprocessable_entity)) }
    end
  end
end
