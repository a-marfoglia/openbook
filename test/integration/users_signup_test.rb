require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get about_path
    assert_no_difference 'User.count' do
      post_via_redirect users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar",
                               forwarding_url: '/about' }
    end
    assert_template 'static_pages/about'
  end

  test "valid signup information" do
    get about_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password",
                                            forwarding_url: '/about' }
    end
    assert_template 'users/show'
  end
end
