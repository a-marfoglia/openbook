require 'test_helper'

class MicropostsTestTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test 'should redirect root if not logged, post if logged' do
    get microposts_path
    assert_template 'microposts/index'
    get_via_redirect new_micropost_path
    assert_template 'static_pages/home'
    assert_select 'div[class=?]', 'alert alert-danger', count: 1
    log_in_as(@user)
    assert_template 'static_pages/home'
    get microposts_path
    assert_template 'microposts/index'
    get new_micropost_path
    assert_template 'microposts/new'
    post_via_redirect microposts_path, micropost: {
                            title: "Example",
                            content: "Example",
                            category_id: Category.first.id
                           }
    assert_template 'microposts/index'
  end
end
