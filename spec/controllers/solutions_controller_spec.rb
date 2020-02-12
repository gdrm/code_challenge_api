require 'rails_helper'

RSpec.describe SolutionsController, type: :request do

  describe '#create' do
    let(:request_url) { "/challenges/#{challenge_id}/solutions" }
    let(:request_headers) { { ACCEPT: 'application/json' } }
    let(:challenge_id) { 99 }
    let(:request_body) do
      {
        code: 'puts "Success"',
        language: 'ruby',
      }
    end

    subject do
      post request_url, params: request_body, headers: request_headers
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

      context 'and the solution is created succesfully' do
        let!(:challenge_id) { create(:challenge).id }
        it do
          expect{ subject }.to change { Solution.all.count }.from(0).to(1)
          solution = Solution.first
          expect(solution).to have_attributes({
            user_id: user_id,
            challenge_id: challenge_id,
            code: 'puts "Success"',
            language: 'ruby'
          })
          expect(subject.status).to eq(204)
        end
      end
    end
  end

  describe '#challenge' do
    let(:request_url) { "/challenges/#{challenge_id}/solutions" }
    let(:request_headers) { { ACCEPT: 'application/json' } }
    let(:request_body) do
      {
        code: 'puts "Success"',
        language: 'ruby',
      }
    end
    let!(:role) { create(:role) }
    let!(:user) { create(:user, role: role) }
    let(:request_headers) do
      { ACCEPT: 'application/json', AUTHORIZATION: JsonWebToken.encode(user_id: user.id) }
    end
    subject do
      get request_url, headers: request_headers
      response
    end

    context 'the challenge does not exist' do
      let(:challenge_id) { 99 }
      it { expect(subject.status).to eq(404) }
    end

    context 'the challenge exist' do
      let!(:challenge) { create(:challenge) }
      let!(:challenge_id) { challenge.id }

      context 'but does not have solutions' do
        let(:expected_result) do
          {
            'solutions' => []
          }
        end
        it do
          expect(subject.status).to eq(200)
          expect(subject.content_type).to eq('application/json; charset=utf-8')
          expect(subject.parsed_body).to eq(expected_result)
        end
      end
      context 'and has solutions' do
        let!(:solution) { create(:solution, user: user, challenge: challenge) }
        let!(:user2) { create(:user, role: role) }
        let!(:solution2) { create(:solution, user: user2, challenge: challenge) }
        let(:expected_result) do
          {
            'solutions' => [
              {
                'id' => solution.id,
                'user_name' => user.name,
                'code' => solution.code,
                'likes' => solution.likes,
                'language' => solution.language,
                'comments' => [],
              },
              {
                'id' => solution2.id,
                'user_name' => user2.name,
                'code' => solution2.code,
                'likes' => solution2.likes,
                'language' => solution2.language,
                'comments' => [],
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
  end

  describe '#show' do
    let(:request_url) { "/challenges/#{challenge_id}/solution" }
    let(:request_headers) { { ACCEPT: 'application/json' } }

    subject do
      get request_url, headers: request_headers
      response
    end

    context 'user is not authenticated' do
      let(:challenge_id) { 1 }
      it { expect(subject.status).to eq(401) }
    end

    context 'user is authenticated' do
      let!(:user_id) { create(:user).id }
      let(:request_headers) do
        { ACCEPT: 'application/json', AUTHORIZATION: JsonWebToken.encode(user_id: user_id) }
      end
      let!(:challenge_id) { create(:challenge).id }

      context 'and solution exists' do
        let!(:solution) { create(:solution, user_id: user_id, challenge_id: challenge_id) }
        let(:expected_result) do
          {
            'code' => solution.code,
            'likes' => solution.likes,
            'language' => solution.language
          }
        end
        it do
          expect(subject.status).to eq(200)
          expect(subject.content_type).to eq('application/json; charset=utf-8')
          expect(subject.parsed_body).to eq(expected_result)
        end
      end

      context 'and solution does not exist' do
        it { expect(subject.status).to eq(404) }
      end
    end
  end

  describe '#update' do
    let(:request_url) { "/challenges/#{challenge_id}/solution" }
    let(:request_headers) { { ACCEPT: 'application/json' } }
    let(:request_body) do
      {
        'code': 'updated code',
        'likes': 2,
        'language': 'python'
      }
    end

    subject do
      put request_url, params: request_body, headers: request_headers
      response
    end

    let!(:role) { create(:role) }
    let!(:user_id) { create(:user, role: role).id }
    let!(:challenge_id) { create(:challenge).id }
    
    context 'user is not authenticated' do
      it { expect(subject.status).to eq(401) }
    end

    context 'user is authenticated' do
      let(:request_headers) do
        { ACCEPT: 'application/json', AUTHORIZATION: JsonWebToken.encode(user_id: user_id) }
      end

      context 'and solution does not exist' do
        it { expect(subject.status).to eq(404) }
      end

      context 'and solution exists' do
        let!(:solution) do
          create(:solution,
            challenge_id: challenge_id,
            user_id: user_id,
            code: 'original code',
            likes: 0,
            language: 'ruby')
        end

        it do
          expect(subject.status).to eq(204)
          expect{solution.reload}.to change{solution.code}.from('original code').to('updated code')
            .and change{solution.likes}.from(0).to(2)
            .and change{solution.language}.from('ruby').to('python')
        end
      end
    end
  end
end
