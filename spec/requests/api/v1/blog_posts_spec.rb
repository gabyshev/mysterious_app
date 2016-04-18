require 'rails_helper'

RSpec.describe 'Blog Posts API', type: :request do
  let(:user)       { create :user }
  let!(:blog_post) { create :blog_post, user: user }
  let(:params)     { { blog_post: { title: 'title', body: 'body', user_id: user.id } } }

  context '#index' do
    before do
      get blog_posts_path, nil, headers
    end

    it { expect(response).to have_http_status(200) }
    it { expect(json).to be_kind_of Array }
    it { expect(json.first.keys).to eq %w(id title created_at author url) }
  end

  context '#show' do
    before do
      get blog_post_path(blog_post), nil, headers
    end

    it { expect(response).to have_http_status(200) }
    it { expect(json.keys).to include 'comments' }
    it { expect(json['comments']).to be_kind_of Array }
  end

  describe 'authorized' do
    let(:token) do
      sign_in user: user
      json['token']
    end
    let(:auth_headers) { headers.merge(authorization: "Bearer #{user.email} #{token}") }

    context '#create' do
      before do
        post blog_posts_path, params, auth_headers
      end

      it { expect(response).to have_http_status(201) }
      it { expect(BlogPost.count).to eq 2 }
    end

    context '#update' do
      let(:params) { { blog_post: { title: 'custom_title' } } }

      before do
        put blog_post_path(blog_post), params, auth_headers
      end

      it { expect(BlogPost.count).to eq 1 }
      it { expect(response).to have_http_status(204) }
      it { blog_post.reload; expect(blog_post.title).to eq params.dig :blog_post, :title }
    end

    context '#destroy' do
      before do
        delete blog_post_path(blog_post), nil, auth_headers
      end

      it { expect(response).to have_http_status(204) }
      it { expect(BlogPost.count).to eq(0) }
    end
  end

  describe 'anonymous' do
    context '#create' do
      it 'returns error' do
        post blog_posts_path, params, headers
        expect(response.status).to eq 401
      end
    end

    context '#update' do
      it 'returns error' do
        put blog_post_path(blog_post), params, headers
        expect(response.status).to eq 401
      end
    end

    context '#destroy' do
      it 'returns error' do
        delete blog_post_path(blog_post), nil, headers
        expect(response.status).to eq 401
      end
    end
  end
end
