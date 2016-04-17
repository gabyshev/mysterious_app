user = User.create(email: 'test@test.com', password: '123123123')

blog_post = user.blog_posts.create(title: 'foo', body: 'bar')

blog_post.comments.create(message: 'foobar', user: user)
