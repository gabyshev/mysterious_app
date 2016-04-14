FactoryGirl.define do
  factory :blog_post do
    user
    title 'Post title'
    body 'Post body'
  end
end
