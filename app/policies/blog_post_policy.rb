class BlogPostPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def update?
    user.admin? || record.user == @user
  end

  def destroy?
    user.admin? || record.user == @user
  end
end
