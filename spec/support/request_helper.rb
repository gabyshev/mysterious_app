module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

  module SessionHelpers
    def sign_in(user: create(:user))
      post user_session_path,
           user: { email: user.email, password: user.password }
    end
  end
end
