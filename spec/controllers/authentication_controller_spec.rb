# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationController, type: :request do
  let(:request_url) { '/login' }
  let(:request_body) { {} }
  let(:request_headers) { { ACCEPT: 'application/json' } }

  subject do
    post request_url, params: request_body, headers: request_headers
    response
  end

  context 'user does not exist' do
    it { expect(subject.status).to eq(404) }
  end

  context 'user exist' do
    let(:email) { 'user@mail.com' }
    let(:pass) { 'asdf' }
    let(:role) { create(:role) }
    let!(:user) do
      create(:user, {
        name: 'Jhon Doe',
        email: email,
        password: pass,
        password_confirmation: pass,
        role: role,
      })
    end
    let(:request_body) do
      {
        email: email,
        password: pass,
      }
    end
    let(:expected_result) do
      {
        'user' => {
          'name' => 'Jhon Doe',
          'email' => email,
          'role_name' => role.name,
        },
        'token' => JsonWebToken.encode(user_id: user.id)
      }
    end
    it do
      expect(subject.status).to eq(200)
      expect(subject.content_type).to eq('application/json; charset=utf-8')
      expect(subject.parsed_body).to eq(expected_result)
    end
  end
end
