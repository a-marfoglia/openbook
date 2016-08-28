require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    get about_path
    assert_template 'static_pages/about'
    post_via_redirect login_path, session: {email: "", password: "", forwarding_url: about_path}
    assert_template 'static_pages/about'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    assert_not is_logged_in?
  end

  test "login with valid information then logout" do
    get about_path
    assert_template 'static_pages/about'
    post_via_redirect login_path, session: {email: @user.email, password: 'password', forwarding_url: about_path}
    assert_template 'static_pages/about'
    assert flash.empty?
    assert_select "a[href=?]", user_path(@user)
    assert is_logged_in?
    delete_via_redirect logout_path
    assert_template 'static_pages/home'
    assert_not is_logged_in?
    delete_via_redirect logout_path
    assert_template 'static_pages/home'
    assert_not is_logged_in?
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
