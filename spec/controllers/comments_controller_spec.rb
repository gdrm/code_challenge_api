require 'rails_helper'

RSpec.describe CommentsController, type: :request do

  describe "#create" do
    let(:request_url) { "/solutions/#{solution_id}/comments" }
    let(:request_headers) { { ACCEPT: 'application/json' } }
    let(:request_body) { { comment: 'My comment' } }
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
        let!(:solution_id) { create(:solution, user_id: user_id, challenge: build(:challenge)).id }
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

  describe '#index' do
    let(:request_url) { "/solutions/#{solution_id}/comments" }
    let(:request_headers) { { ACCEPT: 'application/json' } }
    let(:solution_id) { 999 }

    subject do
      get request_url, headers: request_headers
      response
    end

    context 'user is not authenticated' do
      it { expect(subject.status).to eq(401) }
    end

    context 'user is authenticated' do
      let!(:user) { create(:user) }
      let(:request_headers) do
        { ACCEPT: 'application/json', AUTHORIZATION: JsonWebToken.encode(user_id: user.id) }
      end
      let!(:solution_id) { create(:solution, user: user, challenge: build(:challenge)).id }
      
      context 'and solution does not have comments' do
        it { expect(subject.status).to eq(404) }
      end

      context 'and solution has comments' do
        let!(:comments) { create_list(:comment, 10, solution_id: solution_id, user: user)}
        let(:expected_result) do
          comments.each_with_object({}) do |i,h|
            (h['comments'] ||= []) << {
              'user_name' => user.name,
              'comment' => i.comment,
              'created_at' => i.created_at.strftime("%FT%T.%LZ")
            }
          end
        end
        it do
          expect(subject.status).to eq(200)
          expect(subject.content_type).to eq('application/json; charset=utf-8')
          expect(subject.parsed_body).to eq(expected_result)
        end  
      end
    end
  end
end
