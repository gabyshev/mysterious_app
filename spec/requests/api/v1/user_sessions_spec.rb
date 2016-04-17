require 'rails_helper'

RSpec.describe 'User Sessions API', type: :request do
  context 'POST /api/v1/users' do
    context 'success' do
      before do
        post user_registration_path,
             { user: { email: 'test@test.com', password: '123123123' } },
             headers
      end

      it { expect(response).to have_http_status(201) }
      it { expect(json['token']).to be_nil }
      it { expect(User.count).to eq(1) }
    end

    context 'failure' do
      context 'invalid email' do
        let!(:user) { create :user }
        before do
          post user_registration_path,
               { user: { email: user.email, password: '123123123' } },
               headers
        end

        it { expect(response).to have_http_status(422) }
        it { expect(json['errors'].keys).to include 'email' }
        it { expect(json['errors']['email']).to eq ['has already been taken'] }
      end

      context 'invalid password' do
        before do
          post user_registration_path,
               { user: { email: 'test@test.com', password: '123123' } },
               headers
        end
        it { expect(response).to have_http_status(422) }
        it { expect(json['errors'].keys).to include 'password' }
        it { expect(json['errors']['password']).to eq ['is too short (minimum is 8 characters)'] }
      end
    end
  end

  context 'POST api/v1/users/sign_in' do
    let(:user) { create :user }

    context 'success' do
      before do
        post user_session_path,
             { user: { email: user.email, password: '123123123' } },
             headers
      end

      it { expect(response).to have_http_status(200) }
      it { expect(json['token']).to_not be_nil }
    end

    context 'failure' do
      before do
        post user_session_path,
             { user: { email: user.email, password: '123123345' } },
             headers
      end

      it { expect(response).to have_http_status(401) }
      it { expect(json['error']).to eq 'Invalid email or password.' }
    end
  end
end
