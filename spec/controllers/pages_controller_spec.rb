require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  context 'GET home' do
    it { is_expected.to(route(:get, '/en/home').to(action: :home, locale: :en)) }

    context 'with user sign_in' do
      let(:user) { User.new(attributes_for(:user)) }

      before {
        user.save_in_cache
        request.session[:user_email] = user.email

        get :home, params: { locale: :en }
      }

      it { is_expected.to(redirect_to(registration_path(user))) }
      it { is_expected.to(respond_with(:found)) }
    end

    context 'with user no sign_in' do
      before { get :home, params: { locale: :en } }

      it { is_expected.to(redirect_to(new_registration_path)) }
      it { is_expected.to(respond_with(:found)) }
    end
  end
end
