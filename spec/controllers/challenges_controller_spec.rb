# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChallengesController, type: :request do
  let(:request_url) { '/challenges' }
  let(:request_headers) { { ACCEPT: 'application/json' } }

  subject do
    get request_url, headers: request_headers
    response
  end

  context 'user is not authenticated' do
    it { expect(subject.status).to eq(401) }
  end

  context 'user is authenticated' do
    let!(:user_id) { create(:user).id }
    let(:request_headers) do
      { ACCEPT: 'application/json', AUTHORIZATION: JsonWebToken.encode(user_id: user_id) }
    end
    let!(:challenge) { create(:challenge) }
    let(:expected_result) do
      {
        'challenges' => [
          {
            'title' => challenge.title,
            'description' => challenge.description,
            'examples' => challenge.examples,
            'test_cases' => challenge.test_cases,
            'challenge_start_at' => challenge.challenge_start_at,
            'challenge_end_at' => challenge.challenge_end_at,
          }
        ]
      }
    end
    it do
      expect(subject.status).to eq(200)
      expect(subject.content_type).to eq('application/json; charset=utf-8')
      expect(subject.parsed_body).to eq(expected_result)
    end
  end
end
