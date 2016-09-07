require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(title: "Lorem", content: "Lorem ipsum", category_id: 1)
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "category id should be present" do
    @micropost.category_id = nil
    assert_not @micropost.valid?
  end

  test "title should be present" do
    @micropost.title = " "
    assert_not @micropost.valid?
  end

  test "content should be present " do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content should be at most 300 characters" do
    @micropost.content = "a" * 301
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal Micropost.first, microposts(:most_recent)
  end

end
