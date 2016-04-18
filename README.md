# Ruby on Rails assessment

Sample Ruby on Rails application with versioned RESTful JSON API.

##### Features:
- Users can register themselves
- Every user can create blog post to share their thoughts
- Users can comment other users's blog posts
- User can edit/delete only his own blog post
- User can delete only his own comment
- Admin user have no restrictions

Original [description](https://docs.google.com/document/d/124CtpHv1lGn2PN_rsuXykHJ_cKkO0CYNjSeESOQFJRM/edit)

## Requirements

- Ruby 2.3.0
- Rails 4.2.6

## Getting Started

1. Clone the repo

  ```
  $ git clone git@github.com:gabyshev/mysterious_app.git
  $ cd mysterious_app
  ```

2. Install dependencies

  ```
  $ bundle install
  ```

3. Watch the specs pass

  ```
  $ rake
  ...
  44 examples, 0 failures
  ```

## What's interesting?

There are few suite spots in this repository

#### Authentication && Authorization

I have used `devise` with some improvements.

- Due to testing purposes I [do not include](app/config/routes.rb) ability for users to edit and delete their profiles
- After successful sign in user get auth token [generated](lib/auth_token.rb) with `JWT`
- Auth token lives 24 hours
- Auth token always checked in modifying operations. E.g. in `create`, `update`, `destroy` actions with [`verify_jwt_token`](app/controllers/application_controller.rb)
- `Pundit` policies checks if user can modify data

#### API

There are several approaches to build an API. Personally I think that using version as a part of url is not semantically right thing to do. I'm passing `accept` header with api version provided.
[Here](http://blog.steveklabnik.com/posts/2011-07-03-nobody-understands-rest-or-http#i_want_my_api_to_be_versioned) is more about it.

- [Api constraint](app/constraints/api_constraint.rb) to parse and check `accept` header
- `active_model_serializers` to have custom json [response](app/serializers)


#### Tests

I have covered:
- [requests](spec/requests/api/v1/)
- [lib](spec/lib/auth_token_spec.rb)
- [policies](spec/policies)

Run:

```
rake
```
