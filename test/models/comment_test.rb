require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
    @comment = @micropost.comments.build(content: "Wow, this is a comment!", user_id: @user.id) 
  end
  
  test "should be valid" do
    assert @comment.valid?, @comment.errors.full_messages
  end
  
  test "content should be present" do
    @comment.content = "  "
    assert_not @comment.valid?
  end
  
  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "micropost id should be present" do
    @comment.micropost_id = nil
    assert_not @comment.valid?
  end
end
