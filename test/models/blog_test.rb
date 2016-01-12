require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  test "should fetch title word frequencies wither for lowercase or uppercase words" do
    Blog.create title: 'rails basics', content: 'rails content'
    Blog.create title: 'advanced Rails', content: 'rails content full'

    hashObject = Blog.new.fetch_title_word_frequencies

    assert_equal 2, hashObject['rails']
    assert_equal 1, hashObject['basics']
  end
end
