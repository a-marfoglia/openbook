require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
  end

  test 'should redirect if not logged in, else post' do
    get micropost_path(@micropost)
    assert_template 'microposts/show'
    assert_no_difference 'Comment.count' do
      post_via_redirect comments_path comment: { content: "Example", micropost_id: @micropost.id }    
    end
    assert_template 'static_pages/home'
    assert_select 'div[class=?]', 'alert alert-danger', count: 1
    log_in_as(@user)
    get micropost_path(@micropost)
    assert_template 'microposts/show'
    assert_difference 'Comment.count', 1 do
      post_via_redirect comments_path comment: { content: "Example", micropost_id: @micropost.id }
      assert_template 'microposts/show'
    end
  end
end
