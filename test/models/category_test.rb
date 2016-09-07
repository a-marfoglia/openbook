require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "Esempio")
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "shouldn't be valid" do
    @category.name = " "
    assert_not @category.valid?
  end
  
  test "there should be at least one category (Fixtures)" do
    assert_operator Category.count, :>, 0
  end
end
