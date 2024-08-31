require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build_stubbed(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  it { is_expected.to(have_secure_password(:password)) }
  it { is_expected.to(validate_length_of(:name).is_at_least(5).is_at_most(128)) }
  it { is_expected.to(validate_presence_of(:email)) }
  it { is_expected.to(validate_length_of(:email).is_at_most(255)) }
  it { is_expected.to(validate_confirmation_of(:password)) }
  it { is_expected.to(validate_length_of(:password).is_at_most(72).is_at_least(10)) }


  context 'when validates email' do
    context 'with valid email format' do
      it 'has no invalid email message' do
        user.valid?
        expect(user.errors[:email]).to_not include('is invalid')
      end
    end

    context 'with invalid email format' do
      let(:user) { build_stubbed(:user, email: 'sda') }

      it 'has invalid email message' do
        user.valid?
        expect(user.errors[:email]).to include('is invalid')
      end
    end
  end

  context 'when validates password' do
    context 'with password having 2 numbers at least' do
      it 'has no digit message' do
        user.valid?
        expect(user.errors[:password]).to_not include('must have 2 digits at least')
      end
    end

    context 'with password no having 2 numbers at least' do
      it 'has digit message' do
        user.password = 'test'
        user.valid?
        expect(user.errors[:password]).to include('must have 2 digits at least')
      end
    end

    context 'with password having 2 lowercase characters at least' do
      it 'has no lowercase message' do
        user.valid?
        expect(user.errors[:password]).to_not include('must have 2 lowercase character at least')
      end
    end

    context 'with password no having 2 lowercase characters at least' do
      it 'has lowercase message' do
        user.password = 'TEST'
        user.valid?
        expect(user.errors[:password]).to include('must have 2 lowercase character at least')
      end
    end

    context 'with password having 2 uppercase characters at least' do
      it 'has no uppercase message' do
        user.valid?
        expect(user.errors[:password]).to_not include('must have 2 uppercase character at least')
      end
    end

    context 'with password no having 2 lowers characters at least' do
      it 'has uppercase message' do
        user.password = 'test'
        user.valid?
        expect(user.errors[:password]).to include('must have 2 uppercase character at least')
      end
    end

    context 'with password having 2 special characters at least' do
      it 'has no special character message' do
        user.valid?
        expect(user.errors[:password]).to_not include('must have 2 special character at least')
      end
    end

    context 'with password no having 2 lowers characters at least' do
      it 'has special character message' do
        user.password = 'test'
        user.valid?
        expect(user.errors[:password]).to include('must have 2 special character at least')
      end
    end
  end
end
