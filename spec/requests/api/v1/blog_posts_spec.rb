require 'rails_helper'

RSpec.describe 'Blog Posts API', type: :request do
  let!(:blog_post) { create :blog_post }
  let(:user) { create :user }
  let(:params) { { blog_post: { title: 'title', body: 'body', user_id: user } } }

  context '#index' do
    it 'returns array of blog posts' do
      get blog_posts_path
      expect(response.status).to eq 200
      expect(json).to be_kind_of Array
    end
  end

  context '#show' do
    it 'returns blog post' do
      get blog_post_path(blog_post)
      expect(response.status).to eq 200
    end
  end

  describe 'authorized' do
    let(:token) do
      sign_in user: user
      json['token']
    end
    let(:headers) { { 'Authorization' => "Bearer #{user.email} #{token}" } }

    context '#create' do
      subject(:req) { post blog_posts_path, params, headers }
      it { expect { req }.to change { BlogPost.count }.by(1) }
    end

    context '#update' do
      it 'updates blog_post' do
        params = { blog_post: { title: 'custom_title' } }
        expect { put blog_post_path(blog_post), params, headers }
          .to_not change { BlogPost.count }
        blog_post.reload
        expect(blog_post.title).to eq params.dig :blog_post, :title
      end
    end

    context '#destroy' do
      it 'deletes blog_post' do
        expect { delete blog_post_path(blog_post), nil, headers }
          .to change { BlogPost.count }.to(0)
        expect(response.status).to eq 204
      end
    end
  end

  describe 'anonymous' do
    context '#create' do
      it 'returns error' do
        post blog_posts_path, params
        expect(response.status).to eq 401
      end
    end

    context '#update' do
      it 'returns error' do
        put blog_post_path(blog_post), params
        expect(response.status).to eq 401
      end
    end

    context '#destroy' do
      it 'returns error' do
        delete blog_post_path(blog_post)
        expect(response.status).to eq 401
      end
    end
  end
end
