require 'minitest/autorun'
require 'active_model'
require 'date'

require_relative '../spec_helper_lite'
require_relative '../../app/models/post'

describe Post do
  before do
    @it = Post.new
  end

  it "starts with blank attributes" do
    @it.title.must_be_nil
    @it.body.must_be_nil
  end

  it "supports reading and writing a title" do
    @it.title = "foo"
    @it.title.must_equal "foo"
  end

  it "supports reading and writing a post body" do
    @it.body = "foo"
    @it.body.must_equal "foo"
  end

  it "supports reading and writing a blog reference" do
    blog     = Object.new
    @it.blog = blog
    @it.blog.must_equal blog
  end

  describe "#publish" do
    before do
      @blog    = stub!
      @it.blog = @blog
    end

    it "adds the post to the blog" do
      @blog.expect :add_entry, nil, [@it]
      @it.publish
    end

    it "is not valid with a blank title" do
      [nil, "", " "].each do |bad_title|
        @it.title = bad_title
        refute @it.valid?
      end
    end

    it "is valid with a non-blank title" do
      @it.title = "x"
      assert @it.valid?
    end

    describe "given an invalid post" do
      before do
        @it.title = nil
      end

      it "wont add the post to the blog" do
        dont_allow(@blog).add_entry
        @it.publish
      end

      it "returns false" do
        refute(@it.publish)
      end
    end

    after do
      @blog.verify
    end
  end

  describe "#pubdate" do
    describe "before publishing" do
      it "is blank" do
        @it.pubdate.must_be_nil
      end
    end

    describe "after publishing" do
      before do
        @clock = stub!
        @now = DateTime.parse("2011-09-11T02:56")
        stub(@clock).now(){@now}
        @it.blog = stub!
        @it.title = "blah!"
        @it.publish(@clock)
      end

      it "is a datetime" do
        @it.pubdate.must_equal(@now)
      end
    end
  end

end
