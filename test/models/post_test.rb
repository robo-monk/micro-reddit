require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @post = Post.new(title: 'Dump title', body: 'lmao dude funny sotry')
  end

  test 'default post should be valid' do
    assert @post.valid?
  end

  test 'post should have title' do
    @post.title = ''
    assert_not @post.valid?
  end
end
