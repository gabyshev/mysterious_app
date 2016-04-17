FactoryGirl.define do
  factory :comment do
    blog_post blog_post
    user user
    message 'my comment'
  end
end
