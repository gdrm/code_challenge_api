require 'rails_helper'

RSpec.describe CommentsController, type: :request do

  describe "#create" do
    let(:request_url) { "/solutions/#{solution_id}/comments" }
    let(:request_headers) { { ACCEPT: 'application/json' } }
    let(:request_body) do
      {
        comment: 'My comment'
      }
    end
    let(:solution_id) { 999 }

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

      context 'and solution does not exist' do
        it { expect(subject.status).to eq(404) }
      end

      context 'and solution exists' do
        let!(:solution) { create(:solution, user_id: user_id, challenge: build(:challenge)) }
        let(:solution_id) { solution.id }
        it do
          expect{ subject }.to change { Comment.all.count }.from(0).to(1)
          expect(Comment.first).to have_attributes({
            user_id: user_id,
            solution_id: solution_id,
            comment: request_body[:comment],
            })
          expect(subject.status).to eq(204)
        end
      end
    end
  end
end
