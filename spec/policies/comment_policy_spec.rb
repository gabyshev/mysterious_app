require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { CommentPolicy }

  let(:user) { build_stubbed :user }
  let(:comment) { build_stubbed :comment, user: user }

  permissions :update?, :destroy? do
    context 'role :user' do
      let(:other_user) { build_stubbed :user }

      it 'can modify his own comment' do
        expect(subject).to permit(user, comment)
      end

      it "cannot modify other user's comment" do
        expect(subject).to_not permit(other_user, comment)
      end
    end

    context 'role :admin' do
      let(:admin) { build_stubbed :user, :admin }

      it 'can modify any comment' do
        expect(subject).to permit(admin, comment)
      end
    end
  end
end
