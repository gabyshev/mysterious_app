require 'rails_helper'

RSpec.describe 'Blog Posts API', type: :request do
  let!(:blog_post) { create :blog_post }

  describe 'authorized' do
    let(:user) { create :user }
    let(:token) do
      sign_in user: user
      json['token']
    end
    let(:headers) { { 'Authorization' => "Bearer #{user.email} #{token}" } }

    context '#create' do
      let(:params) { { blog_post: { title: 'title', body: 'body', user_id: user } } }
      subject(:req) { post blog_posts_path, params, headers }

      it { expect { req }.to change { BlogPost.count }.by(1) }
    end

    context '#show' do
      it 'returns blog post' do
        get blog_post_path(blog_post), nil, headers
        expect(response.status).to eq 200
      end
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
    context 'returns 401 error' do
      let(:params) { { blog_post: { title: 'foo', body: 'bar' } } }
      it 'on #create' do
        post blog_posts_path, params
        expect(response.status).to eq 401
      end

      it 'on #update' do
        put blog_post_path(blog_post), params
        expect(response.status).to eq 401
      end

      it 'on #destroy' do
        delete blog_post_path(blog_post)
        expect(response.status).to eq 401
      end
    end

  end
end
