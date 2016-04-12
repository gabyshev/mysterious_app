require 'rails_helper'

RSpec.describe 'User Sessions API', type: :request do
  context 'POST /api/v1/users' do
    it 'successfully signs up user' do
      post user_registration_path,
           user: { email: 'test@test.com', password: '123123123' }
      expect(response.status).to eq 201
      expect(json['token']).to be_nil
    end

    context 'failure' do
      let!(:user) { create :user }

      it 'shows email error message' do
        post user_registration_path,
             user: { email: user.email, password: '123123123' }

        expect(response.status).to eq 422
        expect(json['errors'].keys).to include 'email'
        expect(json['errors']['email']).to eq ['has already been taken']
      end

      it 'shows password error message' do
        post user_registration_path,
             user: { email: 'test@test.com', password: '123123' }

        expect(response.status).to eq 422
        expect(json['errors'].keys).to include 'password'
        expect(json['errors']['password']).to eq ['is too short (minimum is 8 characters)']
      end
    end
  end

  context 'POST api/v1/users/sign_in' do
    let(:user) { create :user }

    context 'success' do
      before do
        post user_session_path,
             user: { email: user.email,  password: '123123123' }
      end

      it 'signs user in' do
        expect(response.status).to eq 200
      end

      it 'response have token' do
        expect(json['token']).to_not be_nil
      end
    end

    context 'failure' do
      it 'shows erros message' do
        post user_session_path,
             user: { email: user.email, password: '123123345' }
        expect(response.status).to eq 401
      end
    end
  end
end
