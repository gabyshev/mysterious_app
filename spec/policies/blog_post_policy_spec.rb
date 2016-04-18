require 'rails_helper'

RSpec.describe BlogPostPolicy do
  subject { BlogPostPolicy }

  let(:user)      { build_stubbed :user }
  let(:blog_post) { build_stubbed :blog_post, user: user }

  permissions :update?, :destroy? do
    context 'role :user' do
      let(:other_user) { build_stubbed :user }

      it 'can modify his own blog post' do
        expect(subject).to permit(user, blog_post)
      end

      it "cannot modify other user's blog post" do
        expect(subject).to_not permit(other_user, blog_post)
      end
    end

    context 'role :admin' do
      let(:admin) { build_stubbed :user, :admin }

      it 'can modify any blog post' do
        expect(subject).to permit(admin, blog_post)
      end
    end
  end
end
