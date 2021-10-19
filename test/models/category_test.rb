require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup            #setup is the mehod which runned before ecah test, so we can use it to avoid redundancy
    @category = Category.new(name: "sports")

  end


  test "Category should be valid!!" do
    # @category = Category.new(name: "sports")
    assert @category.valid?
  end

  test "Name should not be empty" do
    # @category = Category.new(name: "")
    @category.name=""
    assert_not @category.valid?       #@category is not valid, since no name
  end

  test "Name should be unique" do
    @category.save
    @category2 = Category.new(name:"Sports")
    assert_not @category2.valid?
    
  end

  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "Name should not be too short" do
    @category.name ="aa"
    assert_not @category.valid?
  end

end