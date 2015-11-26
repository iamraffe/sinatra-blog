require_relative 'post.rb'
class Blog 
  def posts
    Post.order("created_at DESC")
  end

  def add_post(post)
    Post.new(post)
  end

  def view_post(id)
    Post.find(id)
  end
end