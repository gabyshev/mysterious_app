puts 'Creating users..'
User.create(email: 'admin@test.com', password: '123123123', role: 'admin')
user = User.create(email: 'test@test.com', password: '123123123')

puts 'Creating blog post..'
blog_post = user.blog_posts.create(title: 'foo', body: 'bar')

puts 'Creating comment..'
blog_post.comments.create(message: 'foobar', user: user)
