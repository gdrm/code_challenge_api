# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :request do

  describe '#edit' do
    let(:request_url) { "/users/#{user_id}" }
    let(:request_body) { {} }
    let(:request_headers) { { ACCEPT: 'application/json' } }
    let(:name) { 'EditedName' }
    let(:pass) { 'EditedPass' }
    let(:request_body) do
      {
        name: name,
        password: pass,
      }
    end

    subject do
      put request_url, params: request_body, headers: request_headers
      response
    end
  
    context 'user is authenticated' do
      let!(:user_id) { create(:user, name: 'OriginalName').id }
      let(:request_headers) do
        { ACCEPT: 'application/json', AUTHORIZATION: JsonWebToken.encode(user_id: user_id) }
      end
  
      let!(:user) { User.find(user_id) }

      it do
        expect(subject.status).to eq(204)
        expect{user.reload}.to change{user.name}.from('OriginalName').to('EditedName')
                           .and change{user.password_digest}
      end
    end

    context 'user is not authenticated' do
      let!(:user_id) { create(:user).id }
      let(:request_headers) do
        { ACCEPT: 'application/json'}
      end

      it do
        expect(subject.status).to eq(401)
      end
    end

  end
end
