require 'rails_helper'

RSpec.describe BlogPostPolicy do
  subject { BlogPostPolicy }

  let(:user)      { build_stubbed :user }
  let(:blog_post) { build_stubbed :blog_post, user: user }

  permissions :update?, :destroy? do
    context 'role :user' do
      let(:other_user) { build_stubbed :user }
      let(:other_blog_post) { build_stubbed :blog_post, user: other_user }
      it 'should allow user to modify his own blog post' do
        expect(subject).to permit(user, blog_post)
      end

      it "should not allow user to modify other user's blog post" do
        expect(subject).to_not permit(user, other_blog_post)
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
