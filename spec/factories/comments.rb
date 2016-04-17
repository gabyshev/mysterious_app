FactoryGirl.define do
  factory :comment do
    blog_post
    user
    message 'my comment'
  end
end
