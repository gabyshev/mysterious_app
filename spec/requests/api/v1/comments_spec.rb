require 'rails_helper'

RSpec.describe 'Comments API', type: :request do
  let(:user)      { create :user }
  let(:blog_post) { create :blog_post }
  let(:token) do
    sign_in user: user
    json['token']
  end
  let(:auth_headers) { headers.merge(authorization: "Bearer #{user.email} #{token}") }

  context '#create' do
    before do
      post blog_post_comments_path(blog_post),
           { comment: { message: 'foobar' } },
           auth_headers
    end

    it { expect(response).to have_http_status(201) }
    it { expect(Comment.count).to eq(1) }
  end

  context '#delete' do
    let(:comment) { create :comment, user: user }
    before do
      delete blog_post_comment_path(blog_post, comment), nil, auth_headers
    end

    it { expect(response).to have_http_status(204) }
    it { expect(Comment.count).to eq(0) }
  end
end
