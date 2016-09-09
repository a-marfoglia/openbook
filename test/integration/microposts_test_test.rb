require 'test_helper'

class MicropostsTestTest < ActionDispatch::IntegrationTest
  test 'should redirect root if not logged' do
    get microposts_path
    assert_template 'microposts/index'
    get_via_redirect new_micropost_path
    assert_template 'static_pages/home'
    assert_select 'div[class=?]', 'alert alert-danger', count: 1
  end
end
