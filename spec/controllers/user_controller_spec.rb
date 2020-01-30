# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :request do

  describe '#edit' do
    let(:request_url) { "/users/#{user_id}" }
    let(:request_body) { {} }
    let(:request_headers) { { ACCEPT: 'application/json' } }

    subject do
      post request_url, params: request_body, headers: request_headers
      response
    end
  
    context 'user is authenticated' do
      let!(:user_id) { create(:user).id }
      let(:request_headers) do
        { ACCEPT: 'application/json', AUTHORIZATION: JsonWebToken.encode(user_id: user_id) }
      end
      let(:name) { 'EditedName' }
      let(:pass) { 'EditedPass' }

      let(:request_body) do
        {
          name: name,
          password: pass,
        }
      end
  
      let(:user) { User.find(user_id) }

      it do
        expect(subject.status).to eq(200)
        expect(subject.content_type).to eq('application/json')
        expect(user.name).to eq(name)
      end
    end
  end
end
