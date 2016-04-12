require 'rails_helper'
require 'auth_token'

describe 'Auth Token' do
  context 'issuing token' do
    it 'should fail with nil payload' do
      expect { AuthToken.issue_token(nil) }
        .to raise_error(AuthToken::InvalidPayload)
    end

    it 'should issue token' do
      expect(AuthToken.issue_token.class).to be String
    end
  end

  context 'validating token' do
    let(:payload) { { test: 'payload' } }
    let(:token) { AuthToken.issue_token(payload) }

    it 'validates token' do
      expect { AuthToken.valid?(token) }.to_not raise_error
      expect(AuthToken.valid?(token)).to_not be_falsey
    end

    it 'returns the same payload' do
      expect(AuthToken.valid?(token)[0]['test']).to eq payload[:test]
    end

    it 'exp field pointing to tomorrow' do
      timestamp = AuthToken.valid?(token)[0]['exp'].to_s
      expect(DateTime.strptime(timestamp, '%s').to_date).to eq DateTime.tomorrow
    end
  end
end
