class Blog

  attr_writer :post_source

  def initialize
    @entries = []
  end

  def title
    "watching paint dry"
  end

  def subtitle
    "The trusted source for drying paint"
  end

  def new_post(*args)
    post_source.call(*args).tap do |p|
      p.blog = self
    end
  end

  def add_entry(entry)
    @entries << entry
  end

  def entries
    @entries.sort_by{ |e| e.pubdate}.reverse.take(10)
  end

  private

  def post_source
    @post_source ||= Post.public_method(:new)
  end

end
